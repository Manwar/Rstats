use Test::More 'no_plan';
use strict;
use warnings;

use Rstats::Util;
use Scalar::Util 'refaddr';

# reference
{
  my $na = Rstats::Util::NA;
  is(ref $na, 'Rstats::Type::NA');
}

# singleton
{
  my $na1 = Rstats::Util::NA;
  my $na2 = Rstats::Util::NA;
  is(refaddr $na1, refaddr $na2);
}

# negation
{
  my $na1 = Rstats::Util::NA;
  my $na2 = -$na1;
  ok(Rstats::Util::is_na($na2));
}

# bool
{
  my $na = Rstats::Util::NA;
  eval { if ($na) { 1 } };
  like($@, qr/bool/);
}

# to_string
{
  my $na = Rstats::Util::NA;
  is("$na", 'NA');
}

# is_na
{
  my $na = Rstats::Util::NA;
  ok(Rstats::Util::is_na($na));
}
