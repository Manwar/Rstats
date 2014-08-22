use Test::More 'no_plan';
use strict;
use warnings;

use Rstats::Class;
use Rstats::ElementFunction;

my $r = Rstats::Class->new;

# comparison operator
{
  # comparison operator - ==, true
  {
    my $z1 = Rstats::ElementFunction::complex(1,2);
    my $z2 = Rstats::ElementFunction::complex(1,2);
    my $ret = Rstats::ElementFunction::equal($z1, $z2);
    is($ret, Rstats::ElementFunction::TRUE);
  }
  # comparison operator - ==, false
  {
    my $z1 = Rstats::ElementFunction::complex(1,2);
    my $z2 = Rstats::ElementFunction::complex(1,1);
    my $ret = Rstats::ElementFunction::equal($z1, $z2);
    is($ret, Rstats::ElementFunction::FALSE);
  }

  # comparison operator - !=, true
  {
    my $z1 = Rstats::ElementFunction::complex(1,2);
    my $z2 = Rstats::ElementFunction::complex(1,2);
    is(Rstats::ElementFunction::not_equal($z1, $z2), Rstats::ElementFunction::FALSE);
  }
  
  # comparison operator - !=, false
  {
    my $z1 = Rstats::ElementFunction::complex(1,2);
    my $z2 = Rstats::ElementFunction::complex(1,1);
    is(Rstats::ElementFunction::not_equal($z1, $z2), Rstats::ElementFunction::TRUE);
  }

  # comparison operator - <, error
  {
    my $z1 = Rstats::ElementFunction::complex(1,2);
    my $z2 = Rstats::ElementFunction::complex(1,2);
    eval { my $result = Rstats::ElementFunction::less_than($z1, $z2) };
    like($@, qr/invalid/);
  }

  # comparison operator - <=, error
  {
    my $z1 = Rstats::ElementFunction::complex(1,2);
    my $z2 = Rstats::ElementFunction::complex(1,2);
    eval { my $result = Rstats::ElementFunction::less_than_or_equal($z1, $z2) };
    like($@, qr/invalid/);
  }

  # comparison operator - >, error
  {
    my $z1 = Rstats::ElementFunction::complex(1,2);
    my $z2 = Rstats::ElementFunction::complex(1,2);
    eval { my $result = Rstats::ElementFunction::more_than($z1, $z2) };
    like($@, qr/invalid/);
  }

  # comparison operator - >=, error
  {
    my $z1 = Rstats::ElementFunction::complex(1,2);
    my $z2 = Rstats::ElementFunction::complex(1,2);
    eval { my $result = Rstats::ElementFunction::more_than_or_equal($z1, $z2) };
    like($@, qr/invalid/);
  }
}

# to_string
{
  # to_string - basic
  {
    my $z1 = Rstats::ElementFunction::complex(1,2);
    is(Rstats::ElementFunction::to_string($z1), "1+2i");
  }
  
  # to_string - image number is 0
  {
    my $z1 = Rstats::ElementFunction::complex(1,0);
    is(Rstats::ElementFunction::to_string($z1), "1+0i");
  }
  
  # to_string - image number is minus
  {
    my $z1 = Rstats::ElementFunction::complex(1, -1);
    is(Rstats::ElementFunction::to_string($z1), "1-1i");
  }
}

# new
{
  # new
  {
    my $z1 = Rstats::ElementFunction::complex(1,2);
    is($z1->re->value, 1);
    is($z1->im->value, 2);
  }
}

# operation
{
  # operation - negation
  {
    my $z1 = Rstats::ElementFunction::complex(1,2);
    my $z2 = Rstats::ElementFunction::negation($z1);
    is($z2->re->value, -1);
    is($z2->im->value, -2);
  }
  
  # operation - add
  {
    my $z1 = Rstats::ElementFunction::complex(1,2);
    my $z2 = Rstats::ElementFunction::complex(3,4);
    my $z3 = Rstats::ElementFunction::add($z1, $z2);
    is($z3->re->value, 4);
    is($z3->im->value, 6);
  }
  
  # operation - subtract
  {
    my $z1 = Rstats::ElementFunction::complex(1,2);
    my $z2 = Rstats::ElementFunction::complex(3,4);
    my $z3 = Rstats::ElementFunction::subtract($z1, $z2);
    is($z3->re->value, -2);
    is($z3->im->value, -2);
  }
  
  # operation - multiply
  {
    my $z1 = Rstats::ElementFunction::complex(1, 2);
    my $z2 = Rstats::ElementFunction::complex(3, 4);
    my $z3 = Rstats::ElementFunction::multiply($z1, $z2);
    is($z3->re->value, -5);
    is($z3->im->value, 10);
  }

  # operation - abs
  {
    my $z1 = Rstats::ElementFunction::complex(3, 4);
    my $abs = Rstats::ElementFunction::abs($z1);
    is($abs->value, 5);
  }
  
  # operation - Conj
  {
    my $z1 = Rstats::ElementFunction::complex(1, 2);
    my $conj = Rstats::ElementFunction::Conj($z1);
    is($conj->re->value, 1);
    is($conj->im->value, -2);
  }
  
  # operation - divide
  {
    my $z1 = Rstats::ElementFunction::complex(5, -6);
    my $z2 = Rstats::ElementFunction::complex(3, 2);
    my $z3 = Rstats::ElementFunction::divide($z1, $z2);
    is($z3->re->value, 3/13);
    is($z3->im->value, -28/13);
  }

  # operation - raise
  {
    my $z1 = Rstats::ElementFunction::complex(1, 2);
    my $z2 = Rstats::ElementFunction::complex(3, 0);
    my $z3 = Rstats::ElementFunction::raise($z1, $z2);
    is($z3->re->value, -11);
    is($z3->im->value, -2);
  }
}
