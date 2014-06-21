package Rstats::Array;
use Object::Simple -base;
use Carp 'croak';
use List::Util;
use Rstats;

use overload
  bool => sub {1},
  '+' => \&add,
  '-' => \&subtract,
  '*' => \&multiply,
  '/' => \&divide,
  'neg' => \&negation,
  '**' => \&raise,
  '""' => \&to_string,
  fallback => 1;

has 'values';
has 'type';
has 'mode';

sub r { Rstats->new }

sub at {
  my $self = shift;
  
  if (@_) {
    $self->{at} = [@_];
    
    return $self;
  }
  
  return $self->{at};
}

sub value { shift->{values}[0] }

my $r = Rstats->new;

sub new {
  my $self = shift->SUPER::new(@_);
  
  $self->{values} ||= [];
  $self->{type} ||= 'array';
  if (defined $self->{dim}) {
    $self->dim($self->{dim});
  }
  else {
    my $length = @{$self->{values}};
    $self->dim([$length]);
  }
  $self->{mode} = 'numeric' unless $self->{mode};
  
  return $self;
}

sub is_numeric { (shift->{mode} || '') eq 'numeric' }
sub is_integer { (shift->{mode} || '') eq 'integer' }
sub is_complex { (shift->{mode} || '') eq 'complex' }
sub is_character { (shift->{mode} || '') eq 'character' }
sub is_logical { (shift->{mode} || '') eq 'logical' }

sub as_numeric {
  my $self = shift;

  $self->{mode} = 'numeric';

  return $self;
}

sub as_integer {
  my $self = shift;

  $self->{mode} = 'integer';

  return $self;
}

sub as_complex {
  my $self = shift;

  $self->{mode} = 'complex';

  return $self;
}

sub as_character {
  my $self = shift;

  $self->{mode} = 'character';

  return $self;
}

sub as_logical {
  my $self = shift;

  $self->{mode} = 'logical';

  return $self;
}

sub dim {
  my $self = shift;
  
  if (@_) {
    my $v1 = $_[0];
    if (ref $v1 eq 'Rstats::Array') {
      $self->{dim} = $v1->values;
    }
    elsif (ref $v1 eq 'ARRAY') {
      $self->{dim} = $v1;
    }
    elsif(!ref $v1) {
      $self->{dim} = [$v1];
    }
    else {
      croak "Invalid values is passed to dim argument";
    }
  }
  else {
    my $dim = $self->{dim};
    my $length = @$dim;
    
    my $v1 = Rstats::Array->new(
      values => $dim,
      type => 'matrix',
      dim => [$length]
    );
    
    return $v1;
  } 
}

=pod

sub get {
  my $self = shift;
  
  my $indexes_tmp;
  if (@_) {
    ($indexes_tmp) = @_;
  }
  else {
    ($indexes_tmp) = @{$self->at};
  }
  
  croak "get need one values" unless defined $indexes_tmp;
  return $self->new(values => [$self->{values}[$indexes_tmp - 1]])
    if !ref $indexes_tmp && $indexes_tmp > 0;
  
  my $indexes;
  if (ref $indexes_tmp eq 'CODE') {
    my $values1 = $self->values;
    my @values2 = grep { $indexes_tmp->(); } @$values1;
    return $self->new(values => \@values2);
  }
  elsif (ref $indexes_tmp eq 'ARRAY') {
    $indexes = $indexes_tmp;
  }
  elsif (ref $indexes_tmp eq 'Rstats::Array') {
    $indexes = $indexes_tmp->{values};
    if ($indexes_tmp->is_character) {
      return $self->_get_character($indexes_tmp);
    }
    elsif ($indexes_tmp->is_logical) {
      return $self->_get_logical($indexes_tmp);
    }
  }
  else {
    $indexes = [$indexes_tmp];
  }
  
  # Check index
  my $plus_count;
  my $minus_count;
  for my $index (@$indexes) {
    $plus_count++ if $index > 0;
    $minus_count++ if $index < 0;
    croak "You can't use both plus and minus index"
      if $plus_count && $minus_count;
    croak "0 is invalid index" if $index == 0;
  }
  
  my $values1 = $self->values;
  my @values2;
  if ($plus_count) {
    @values2 = map { $values1->[$_ - 1] } @$indexes;
  }
  else {
    my $indexes_h = {map { -$_ - 1 => 1 } @$indexes};
    for (my $i = 0; $i < @$values1; $i++) {
      push @values2, $values1->[$i] unless $indexes_h->{$i};
    }
  }
  
  return $self->new(values => \@values2);
}

=cut

sub get {
  my ($self, @_indexs) = @_;
  
  unless (@_indexs) {
    @_indexs = @{$self->at};
  }
  
  my $grep_cb;
  my @indexs;
  for my $_index (@_indexs) {
    if (ref $_index eq 'CODE') {
      $grep_cb = $_index;
      last;
    }
    else {
      my $index = $self->r->_v($_index);
      my $index_values = $index->values;
      unless ($index->is_character) {
        my $minus_count = 0;
        for my $index_value (@$index_values) {
          if ($index_value == 0) {
            croak "0 is invalid index";
          }
          else {
            $minus_count++ if $index_value < 0;
          }
        }
        croak "Can't min minus sign and plus sign"
          if $minus_count > 0 && $minus_count != @$index_values;
        $index->{_minus} = 1 if $minus_count > 0;
      }
      
      push @indexs, $index;
    }
  }
  
  # Grep callback
  if ($grep_cb) {
    my $a1_values = $self->values;
    my @values2 = grep { $grep_cb->() } @$a1_values;
    return Rastas::Array->new(values => \@values2, type => 'vector');
  }
  
  my $a1_values = $self->values;
  my $a1_dim = $self->dim->values;
  my @a2_dim;
  for (my $i = 0; $i < @indexs; $i++) {
    my $index = $indexs[$i];
    my $count;
    if ($index->{_minus}) {
      $count = $a1_dim->values->[$i] - @{$index->values};
    }
    else {
      $count = @{$index->values};
    }
    push @a2_dim, $count;
  }
  
  my $index_values = [map { $_->values } @indexs];
  my $ords = $self->_cross_product($index_values);

  my @a2_values;
  for my $ord (@$ords) {
    my $pos = $self->_pos($ord, $a1_dim);
    my $value = $a1_values->[$pos - 1];
    push @a2_values, $value;
  }
  
  return Rstats::Array->new(values => \@a2_values, dim => \@a2_dim);
}

sub _cross_product {
  my ($self, $values) = @_;

  my @idxs = (0) x @$values;
  my @idx_idx = 0..( @idxs - 1 );
  my @array = map { $_->[0] } @$values;
  my $result = [];
  
  LOOP:
  while (1) {
    push @$result, [@array];
  } continue {
    foreach my $i (@idx_idx) {
      if( $idxs[$i] < @{$values->[$i]} - 1 ) {
        $array[$i] = $values->[$i][++$idxs[$i]];
        last;
      }
      
      last LOOP if $i == $idx_idx[-1];
      
      $idxs[$i] = 0;
      $array[$i] = $values->[$i][0];
    }
  }
  
  return $result;
}

sub _pos {
  my ($self, $ord, $dim) = @_;
  
  my $pos = 0;
  for (my $d = 0; $d < @$dim; $d++) {
    if ($d > 0) {
      my $tmp = 1;
      $tmp *= $dim->[$_] for (0 .. $d - 1);
      $pos += $tmp * ($ord->[$d] - 1);
    }
    else {
      $pos += $ord->[$d];
    }
  }
  
  return $pos;
}

sub _get_logical {
  my ($self, $_bools_v) = @_;

  croak "get need one values" unless defined $_bools_v;
  
  my $bools_v = $r->_v($_bools_v);
  my $bools_values = $bools_v->values;
  
  my $values1 = $self->values;
  my @values2;
  for (my $i = 0; $i < @$bools_values; $i++) {
    push @values2, $values1->[$i] if $bools_values->[$i];
  }
  
  return $self->new(values => \@values2);
}

sub _get_character {
  my ($self, $names) = @_;
  
  my $array2 = $names;
  my $array1_names = $r->names($self)->values;
  my $array2_names = $array2->values;
  
  my $array3_values = [];
  for my $array2_name (@$array2_names) {
    my $i = 0;
    for my $array1_name (@$array1_names) {
      if ($array2_name eq $array1_name) {
        push @$array3_values, $self->values->[$i];
        last;
      }
      $i++;
    }
  }
  
  my $array3 = $self->new(values => $array3_values);
  
  return $array3;
}

sub set {
  my ($self, $idx, $v1) = @_;
  
  $self->{values}[$idx - 1] = $v1;
  
  return $self;  
}

sub to_string {
  my $self = shift;

  my $values = $self->values;

  my $str;
  my $names_v = $r->names($self);
  if ($names_v) {
    $str .= join(' ', @{$names_v->values}) . "\n";
  }
  if (@$values) {
    $str .= '[1] ' . join(' ', @$values) . "\n";
  }
  else {
    $str = 'NULL';
  }
  
  return $str;
}

sub negation {
  my $self = shift;
  
  my $v2 = $self->new;
  my $v1_values = $self->values;
  my $v2_values = $v2->values;
  $v2_values->[$_] = -$v1_values->[$_] for (0 .. @$v1_values - 1);
  
  return $v2;
}

sub add { shift->_operation('+', @_) }
sub subtract { shift->_operation('-', @_) }
sub multiply { shift->_operation('*', @_) }
sub divide { shift->_operation('/', @_) }
sub raise { shift->_operation('**', @_) }

my $culcs = {};
my @ops = qw#+ - * / **#;
for my $op (@ops) {
   my $code = <<"EOS";
sub {
  my (\$v1_values, \$v2_values) = \@_;
   
  my \$v1_length = \@{\$v1_values};
  my \$v2_length = \@{\$v2_values};
  my \$longer_length = \$v1_length > \$v2_length ? \$v1_length : \$v2_length;

  my \@v3_values = map {
    \$v1_values->[\$_ % \$v1_length] $op \$v2_values->[\$_ % \$v2_length]
    } (0 .. \$longer_length - 1);
  
  return \@v3_values;
}
EOS
  
  $culcs->{$op} = eval $code;

  croak $@ if $@;
}

sub _operation {
  my ($self, $op, $data, $reverse) = @_;

  my $v1_values;
  my $v2_values;
  if (ref $data eq 'Rstats::Array') {
    $v1_values = $self->values;
    my $v2 = $data;
    $v2_values = $v2->values;
  }
  else {
    if ($reverse) {
      $v1_values = [$data];
      $v2_values = $self->values;
    }
    else {
      $v1_values = $self->values;
      $v2_values = [$data];
    }
  }

  my @v3_values = $culcs->{$op}->($v1_values, $v2_values);
  
  return $self->new(values => \@v3_values);
}

sub is_array {
  my $self = shift;
  
  return $self->{type} eq 'array';
}

sub is_vector {
  my $self = shift;
  
  return $self->{type} eq 'vector';
}

sub is_matrix {
  my $self = shift;
  
  return $self->{type} eq 'matrix';
}

sub as_matrix {
  my $self = shift;
  
  $self->{type} = 'matrix';
  
  return $self;
}

sub as_array {
  my $self = shift;
  
  $self->{type} = 'array';
  
  return $self;
}

sub as_vector {
  my $self = shift;
  
  $self->{type} = 'vector';
  
  return $self;
}

1;

