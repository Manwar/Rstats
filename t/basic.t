use Test::More 'no_plan';
use strict;
use warnings;

use Rstats;
use Math::Trig ();
use Rstats::::Container::Array;

# as_numeric
{
  # as_numeric - from complex
  {
    my $a1 = c(r->complex(1, 1), r->complex(2, 2));
    r->mode($a1 => 'complex');
    my $a2 = r->as_numeric($a1);
    is(r->mode($a2)->value, 'numeric');
    is_deeply($a2->values, [1, 2]);
  }

  # as_numeric - from numeric
  {
    my $a1 = c(0.1, 1.1, 2.2);
    r->mode($a1 => 'numeric');
    my $a2 = r->as_numeric($a1);
    is(r->mode($a2)->value, 'numeric');
    is_deeply($a2->values, [0.1, 1.1, 2.2]);
  }
    
  # as_numeric - from integer
  {
    my $a1 = c(0, 1, 2);
    r->mode($a1 => 'integer');
    my $a2 = r->as_numeric($a1);
    is(r->mode($a2)->value, 'numeric');
    is_deeply($a2->values, [0, 1, 2]);
  }
  
  # as_numeric - from logical
  {
    my $a1 = c(r->TRUE, r->FALSE);
    r->mode($a1 => 'logical');
    my $a2 = r->as_numeric($a1);
    is(r->mode($a2)->value, 'numeric');
    is_deeply($a2->values, [1, 0]);
  }

  # as_numeric - from character
  {
    my $a1 = r->as_integer(c(0, 1, 2));
    my $a2 = r->as_numeric($a1);
    is(r->mode($a2)->value, 'numeric');
    is_deeply($a2->values, [0, 1, 2]);
  }
}
  
# is_*, as_*, typeof
{
  # is_*, as_*, typeof - integer
  {
    my $c = c(0, 1, 2);
    ok(r->is_integer(r->as_integer($c)));
    is(r->mode(r->as_integer($c))->value, 'numeric');
    is(r->typeof(r->as_integer($c))->value, 'integer');
  }
  
  # is_*, as_*, typeof - character
  {
    my $c = c(0, 1, 2);
    ok(r->is_character(r->as_character($c)));
    is(r->mode(r->as_character($c))->value, 'character');
    is(r->typeof(r->as_character($c))->value, 'character');
  }
  
  # is_*, as_*, typeof - complex
  {
    my $c = c(0, 1, 2);
    ok(r->is_complex(r->as_complex($c)));
    is(r->mode(r->as_complex($c))->value, 'complex');
    is(r->typeof(r->as_complex($c))->value, 'complex');
  }
  
  # is_*, as_*, typeof - logical
  {
    my $a1 = c(0, 1, 2);
    my $a2 = r->as_logical($a1);
    ok(r->is_logical($a2));
    is(r->mode($a2)->value, 'logical');
    is(r->typeof($a2)->value, 'logical');
  }

  # is_*, as_*, typeof - NULL
  {
    my $a1 = r->NULL;
    is(r->mode($a1)->value, 'logical');
    is(r->typeof($a1)->value, 'logical');
  }
}

# matrix
{
  {
    my $mat = matrix(0, 2, 5);
    is_deeply($mat->values, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    is_deeply(r->dim($mat)->values, [2, 5]);
    ok(r->is_matrix($mat));
  }
  
  # matrix - repeat values
  {
    my $mat = matrix([1,2], 2, 5);
    is_deeply($mat->values, [1, 2, 1, 2, 1, 2, 1, 2, 1, 2]);
    is_deeply(r->dim($mat)->values, [2, 5]);
    ok(r->is_matrix($mat));
  }
}

# rnorm
{
  my $v1 = r->rnorm(100);
  is(r->length($v1)->value, 100);
}

# sequence
{
  my $v1 = c(1, 2, 3);
  my $v2 = r->sequence($v1);
  is_deeply($v2->values, [1, 1, 2, 1, 2, 3])
}
  
# sample
{
  {
    my $v1 = C('1:100');
    my $v2 = r->sample($v1, 50);
    is(r->length($v2)->value, 50);
    my $duplicate_h = {};
    my $duplicate;
    my $invalid_value;
    for my $v2_value (@{$v2->values}) {
      $duplicate_h->{$v2_value}++;
      $duplicate = 1 if $duplicate_h->{$v2_value} > 2;
      unless (grep { $_ eq $v2_value } (1 .. 100)) {
        $invalid_value = 1;
      }
    }
    ok(!$duplicate);
    ok(!$invalid_value);
  }
  
  # sample - replace => 0
  {
    my $v1 = C('1:100');
    my $v2 = r->sample($v1, 50, {replace => 0});
    is(r->length($v2)->value, 50);
    my $duplicate_h = {};
    my $duplicate;
    my $invalid_value;
    for my $v2_value (@{$v2->values}) {
      $duplicate_h->{$v2_value}++;
      $duplicate = 1 if $duplicate_h->{$v2_value} > 2;
      unless (grep { $_ eq $v2_value } (1 .. 100)) {
        $invalid_value = 1;
      }
    }
    ok(!$duplicate);
    ok(!$invalid_value);
  }

  # sample - replace => 0
  {
    my $v1 = C('1:100');
    my $v2 = r->sample($v1, 50, {replace => 1});
    is(r->length($v2)->value, 50);
    my $duplicate_h = {};
    my $duplicate;
    my $invalid_value;
    for my $v2_value (@{$v2->values}) {
      unless (grep { $_ eq $v2_value } (1 .. 100)) {
        $invalid_value = 1;
      }
    }
    ok(!$invalid_value);
  }
  
  # sample - replace => 0, (strict check)
  {
    my $v1 = c(1);
    my $v2 = r->sample($v1, 5, {replace => 1});
    is(r->length($v2)->value, 5);
    is_deeply($v2->values, [1, 1, 1, 1, 1]);
  }
}

# NULL
{
  my $v1 = r->NULL;
  is_deeply($v1->values, []);
  is("$v1", 'NULL');
  $v1->at(3)->set(5);
  is_deeply($v1->values, [undef, undef, 5]);
}

# runif
{
  {
    srand 100;
    my $rands = [rand 1, rand 1, rand 1, rand 1, rand 1];
    r->set_seed(100);
    my $v1 = r->runif(5);
    is_deeply($v1->values, $rands);
    
    my $v2 = r->runif(5);
    isnt($v1->values->[0], $v2->values->[0]);

    my $v3 = r->runif(5);
    isnt($v2->values->[0], $v3->values->[0]);
    
    my $v4 = r->runif(100);
    my @in_ranges = grep { $_ >= 0 && $_ <= 1 } @{$v4->values};
    is(scalar @in_ranges, 100);
  }
  
  # runif - min and max
  {
    srand 100;
    my $rands = [
      rand(9) + 1,
      rand(9) + 1,
      rand(9) + 1,
      rand(9) + 1,
      rand(9) + 1
    ];
    r->set_seed(100);
    my $v1 = r->runif(5, 1, 10);
    is_deeply($v1->values, $rands);

    my $v2 = r->runif(100, 1, 2);
    my @in_ranges = grep { $_ >= 1 && $_ <= 2 } @{$v2->values};
    is(scalar @in_ranges, 100);
  }
}

# which
{
  my $v1 = c('a', 'b', 'a');
  my $v2 = r->which($v1, sub { $_ eq 'a' });
  is_deeply($v2->values, [1, 3]);
}

# elseif
{
  my $v1 = c(1, 0, 1);
  my $v2 = r->ifelse($v1, 'a', 'b');
  is_deeply($v2->values, ['a', 'b', 'a']);
}

# head
{
  {
    my $v1 = c(1, 2, 3, 4, 5, 6, 7);
    my $head = r->head($v1);
    is_deeply($head->values, [1, 2, 3, 4, 5, 6]);
  }
  
  # head - values is low than 6
  {
    my $v1 = c(1, 2, 3);
    my $head = r->head($v1);
    is_deeply($head->values, [1, 2, 3]);
  }
  
  # head - n option
  {
    my $v1 = c(1, 2, 3, 4);
    my $head = r->head($v1, {n => 3});
    is_deeply($head->values, [1, 2, 3]);
  }
}

# tail
{
  {
    my $v1 = c(1, 2, 3, 4, 5, 6, 7);
    my $tail = r->tail($v1);
    is_deeply($tail->values, [2, 3, 4, 5, 6, 7]);
  }
  
  # tail - values is low than 6
  {
    my $v1 = c(1, 2, 3);
    my $tail = r->tail($v1);
    is_deeply($tail->values, [1, 2, 3]);
  }
  
  # tail - n option
  {
    my $v1 = c(1, 2, 3, 4);
    my $tail = r->tail($v1, {n => 3});
    is_deeply($tail->values, [2, 3, 4]);
  }
}

# to_string
{
  my $array = array(c(1, 2, 3));
  is("$array", "[1] 1 2 3\n");
}

# length
{
  my $array = array(c(1, 2, 3));
  is(r->length($array)->value, 3);
}

# array
{
  {
    my $array = array(25);
    is_deeply($array->values, [25]);
  }
  {
    my $array = array(c(1, 2, 3));
    is_deeply(r->dim($array)->values, [3]);
  }
}

# Array get and set
{
  my $array = array(c(1, 2, 3));
  is_deeply($array->get(1)->values, [1]);
  is_deeply($array->get(3)->values, [3]);
  $array->at(1)->set(5);;
  is_deeply($array->get(1)->values, [5]);
}

# c
{
  # c($array)
  {
    my $v = c(1, 2, 3);
    is_deeply($v->values, [1, 2, 3]);
  }
  
  # c($vector)
  {
    my $v = c(c(1, 2, 3));
    is_deeply($v->values, [1, 2, 3]);
  }
  
  # c(C('1:3')
  {
    my $v = C('1:3');
    is_deeply($v->values, [1, 2, 3]);
  }
  
  # c('0.5*1:3')
  {
    my $v = C('0.5*1:3');
    is_deeply($v->values, [1, 1.5, 2, 2.5, 3]);
  }
}

# rep function
{
  # req($v, {times => $times});
  {
    my $v1 = c(1, 2, 3);
    my $v2 = r->rep($v1, {times => 3});
    is_deeply($v2->values, [1, 2, 3, 1, 2, 3, 1, 2, 3]);
  }
}

# seq function
{
  # seq($from, $to),  n > m
  {
    my $v = r->seq(1, 3);
    is_deeply($v->values, [1, 2, 3]);
  }

  # seq({from => $from, to => $to}),  n > m
  {
    my $v = r->seq({from => 1, to => 3});
    is_deeply($v->values, [1, 2, 3]);
  }
  
  # seq($from, $to),  n < m
  {
    my $v = r->seq(3, 1);
    is_deeply($v->values, [3, 2, 1]);
  }
  
  # seq($from, $to), n = m
  {
    my $v = r->seq(2, 2);
    is_deeply($v->values, [2]);
  }
  
  # seq($from, $to, {by => p}) n > m
  {
    my $v = r->seq(1, 3, {by => 0.5});
    is_deeply($v->values, [1, 1.5, 2.0, 2.5, 3.0]);
  }

  # seq($from, $to, {by => p}) n > m
  {
    my $v = r->seq(3, 1, {by => -0.5});
    is_deeply($v->values, [3.0, 2.5, 2.0, 1.5, 1.0]);
  }
  
  # seq($from, {by => p, length => l})
  {
    my $v = r->seq(1, 3, {length => 5});
    is_deeply($v->values, [1, 1.5, 2.0, 2.5, 3.0]);
  }
  
  # seq(along => $v);
  my $v1 = c(3, 4, 5);
  my $v2 = r->seq({along => $v1});
  is_deeply($v2->values, [1, 2, 3]);
}

# Method
{
  # add (vector)
  {
    my $v1 = c(1, 2, 3);
    my $v2 = c($v1, 4, 5);
    is_deeply($v2->values, [1, 2, 3, 4, 5]);
  }
  # add (array)
  {
    my $v1 = c(c(1, 2), 3, 4);
    is_deeply($v1->values, [1, 2, 3, 4]);
  }
  
  # add to original vector
  {
    my $v1 = c(1, 2, 3);
    $v1->at(r->length($v1)->value + 1)->set(6);
    is_deeply($v1->values, [1, 2, 3, 6]);
  }
  
  # numeric
  {
    my $v1 = r->numeric(3);
    is_deeply($v1->values, [0, 0, 0]);
  }

  # length
  {
    my $v1 = c(1, 2, 4);
    my $length = r->length($v1);
    is($length->value, 3);
  }

  # sum
  {
    my $v1 = c(1, 2, 3);
    my $sum = r->sum($v1);
    is($sum->value, 6);
  }

  # prod
  {
    my $v1 = c(2, 3, 4);
    my $prod = r->prod($v1);
    is($prod->value, 24);
  }
  
  # mean
  {
    my $v1 = c(1, 2, 3);
    my $mean = r->mean($v1);
    is($mean->value, 2);
  }

  # var
  {
    my $v1 = c(2, 3, 4, 7, 9);
    my $var = r->var($v1);
    is($var->value, 8.5);
  }
  
  # sort
  {
    # sort - acending
    {
      my $v1 = c(2, 1, 5);
      my $v1_sorted = r->sort($v1);
      is_deeply($v1_sorted->values, [1, 2, 5]);
    }
    
    # sort - decreasing
    {
      my $v1 = c(2, 1, 5);
      my $v1_sorted = r->sort($v1, {decreasing => 1});
      is_deeply($v1_sorted->values, [5, 2, 1]);
    }
    
    # sort - contain NA or NaN
    {
      my $v1 = c(2, 1, 5, NA, NaN);
      my $v1_sorted = r->sort($v1);
      is_deeply($v1_sorted->values, [1, 2, 5]);
    }
  }
}
