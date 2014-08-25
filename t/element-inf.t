use Test::More 'no_plan';
use strict;
use warnings;

use Rstats::EFunc;
use Scalar::Util 'refaddr';

# Inf
{
  # Inf - singleton
  {
    my $inf = Rstats::EFunc::Inf;
    my $inf2 = Rstats::EFunc::Inf;
  
    is(refaddr $inf, refaddr $inf2);
  }
  
  # Inf - singleton, minus
  {
    my $inf = Rstats::EFunc::Inf;
    my $negative_inf = Rstats::EFunc::negation($inf);
    my $negative_inf2 = Rstats::EFunc::negativeInf;
    is(refaddr $negative_inf, refaddr $negative_inf2);
  }
  
  # Inf - negation
  {
    my $inf = Rstats::EFunc::Inf;
    my $negative_inf = Rstats::EFunc::negation($inf);
    my $negative_inf2 = Rstats::EFunc::negativeInf;
    is(refaddr $negative_inf, refaddr $negative_inf2);
  }

  # Inf - negation repeat
  {
    my $inf = Rstats::EFunc::Inf;
    my $negative_inf = Rstats::EFunc::negation($inf);
    my $inf2 = Rstats::EFunc::negation($negative_inf);
    is(refaddr $inf, refaddr $inf2);
  }
  
  # Inf - to_string, plus
  {
    my $inf = Rstats::EFunc::Inf;
    is("$inf", 'Inf');
  }

  # Inf - to_string, minus
  {
    my $negative_inf = Rstats::EFunc::negativeInf;
    is("$negative_inf", '-Inf');
  }
}

# is_infinite
{
  # is_infinite - Inf, true
  {
    my $inf = Rstats::EFunc::Inf;
    ok($inf->is_infinite);
  }
  
  # is_infinite - -Inf, true
  {
    my $negative_inf = Rstats::EFunc::negativeInf;
    ok($negative_inf->is_infinite);
  }
  
  # is_infinite - Double, false
  {
    my $num = Rstats::Element->new(type => 'double', re => 1);
    ok(!$num->is_infinite);
  }
}

# is_finite
{
  # is_finite - Inf, false
  {
    my $inf = Rstats::EFunc::Inf;
    ok(!$inf->is_finite);
  }
  
  # is_finite - -Inf, false
  {
    my $negative_inf = Rstats::EFunc::negativeInf;
    ok(!$negative_inf->is_finite);
  }
  
  # is_finite - Double, true
  {
    my $num = Rstats::Element->new(type => 'double', dv => 1);
    ok($num->is_finite);
  }
  
  # is_finite - Integer, true
  {
    my $num = Rstats::Element->new(type => 'integer', value => 1);
    ok($num->is_finite);
  }
}
