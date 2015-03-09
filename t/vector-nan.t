use Test::More 'no_plan';
use strict;
use warnings;

use Rstats;

# nan - nan is double
{
  my $x_nan = r->new_double('NaN');
  ok(r->is_double($x_nan));
}

# negation
{
  my $x_nan1 = r->new_double('NaN');
  my $x_nan2 = r->negation($x_nan1);
  ok(r->is_nan($x_nan2)->value);
}

# non - to_string
{
  my $x_nan = r->new_double('NaN');
  is("$x_nan", "[1] NaN\n");
}

