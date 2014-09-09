use Test::More 'no_plan';
use strict;
use warnings;

use Rstats;
use FindBin;

# read_table
{
  # read_table - character, complex, double, integer, logical, sep default(\s+)
  my $d1 = r->read_table("$FindBin::Bin/tdata/read/basic.txt");
  ok($d1->get(1)->is_factor);
  is_deeply($d1->get(1)->values, [qw/2 3 4 5 1/]);
  is_deeply($d1->get(1)->levels->values, [qw/NA NB NC ND NE/]);
  is_deeply($d1->get(2)->values, [{re => 1, im => 1}, {re => 1, im => 2}, {re => 1, im => 3}, {re => 1, im => 4}, undef]);
  is_deeply($d1->get(3)->values, [qw/1.1 1.2 1.3 1.4/, undef]);
  is_deeply($d1->get(4)->values, [qw/1 2 3 4/, undef]);
  is_deeply($d1->get(5)->values, [qw/1 0 1 0/, undef]);
}
