use Test::More 'no_plan';
use strict;
use warnings;

use Rstats::ElementFunction;
use Scalar::Util 'refaddr';

# logical
{
  # logical - singleton, true
  {
    my $true1 = Rstats::ElementFunction::TRUE;
    my $true2 = Rstats::ElementFunction::TRUE;
    is(refaddr $true1, refaddr $true2);
  }
  
  # logical - singleton, false
  {
    my $false1 = Rstats::ElementFunction::FALSE;
    my $false2 = Rstats::ElementFunction::FALSE;
    is(refaddr $false1, refaddr $false2);
  }
  
  # logical - bool, TRUE
  {
    my $true = Rstats::ElementFunction::TRUE;
    ok($true);
  }
  
  # logical - bool, FALSE
  {
    my $false = Rstats::ElementFunction::FALSE;
    ok(!$false);
  }
  
  # negation, true
  {
    my $true = Rstats::ElementFunction::TRUE;
    my $num = Rstats::ElementFunction::negation($true);
    ok($num->is_integer);
    is($num->value, -1);
  }

  # negation, false
  {
    my $false = Rstats::ElementFunction::FALSE;
    my $num = Rstats::ElementFunction::negation($false);
    ok($num->is_integer);
    is($num->value, 0);
  }
  
  # to_string, true
  {
    my $true = Rstats::ElementFunction::TRUE;
    is("$true", 'TRUE');
  }
  
  # to_string, false
  {
    my $false = Rstats::ElementFunction::FALSE;
    is("$false", "FALSE");
  }
}

