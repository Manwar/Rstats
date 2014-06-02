use Test::More 'no_plan';
use strict;
use warnings;

use Data::R;
use Math::Trig ();
use Data::R::Complex;

my $r = Data::R->new;

# Vector
{
  # add
  {
    my $v1 = $r->c([1, 2, 3]);
    my $v2 = $r->c([2, 3, 4]);
    my $v3 = $v1 + $v2;
    is_deeply($v3->values, [3, 5, 7]);
  }
  
  # negation
  {
    my $v1 = $r->c([1, 2, 3]);
    my $v2 = -$v1;
    is_deeply($v2->values, [-1, -2, -3]);
  }
  
  # subtract
  {
    my $v1 = $r->c([1, 2, 3]);
    my $v2 = $r->c([3, 3, 3]);
    my $v3 = $v1 - $v2;
    is_deeply($v3->values, [-2, -1, 0]);
  }
  
  # mutiply
  {
    my $v1 = $r->c([1, 2, 3]);
    my $v2 = $r->c([2, 3, 4]);
    my $v3 = $v1 * $v2;
    is_deeply($v3->values, [2, 6, 12]);
  }
  
  # divide
  {
    my $v1 = $r->c([6, 3, 12]);
    my $v2 = $r->c([2, 3, 4]);
    my $v3 = $v1 / $v2;
    is_deeply($v3->values, [3, 1, 3]);
  }

  # raise
  {
    my $v1 = $r->c([1, 2, 3]);
    my $v2 = $v1 ** 2;
    is_deeply($v2->values, [1, 4, 9]);
  }

  # max
  {
    my $v = $r->c([1, 2, 3]);
    my $max = $r->max($v);
    is($max, 3);
  }
  
  # max - multiple vectors
  {
    my $v1 = $r->c([1, 2, 3]);
    my $v2 = $r->c([4, 5, 6]);
    my $max = $r->max($v1, $v2);
    is($max, 6);
  }
  
  # min
  {
    my $v = $r->c([1, 2, 3]);
    my $min = $r->min($v);
    is($min, 1);
  }
  
  # pmax
  {
    my $v1 = $r->c([1, 6, 3, 8]);
    my $v2 = $r->c([5, 2, 7, 4]);
    my $pmax = $r->pmax($v1, $v2);
    is_deeply($pmax->values, [5, 6, 7, 8]);
  }

  # min - multiple vectors
  {
    my $v1 = $r->c([1, 2, 3]);
    my $v2 = $r->c([4, 5, 6]);
    my $min = $r->min($v1, $v2);
    is($min, 1);
  }
  
  # pmin
  {
    my $v1 = $r->c([1, 6, 3, 8]);
    my $v2 = $r->c([5, 2, 7, 4]);
    my $pmin = $r->pmin($v1, $v2);
    is_deeply($pmin->values, [1, 2, 3, 4]);
  }
  
  # log
  {
    my $v1 = $r->c([2, 3, 4]);
    my $v2 = $r->log($v1);
    is_deeply(
      $v2->values,
      [
        log $v1->values->[0],
        log $v1->values->[1],
        log $v1->values->[2]
      ]
    );
  }

  # exp
  {
    my $v1 = $r->c([2, 3, 4]);
    my $v2 = $r->exp($v1);
    is_deeply(
      $v2->values,
      [
        exp $v1->values->[0],
        exp $v1->values->[1],
        exp $v1->values->[2]
      ]
    );
  }

  # sin
  {
    my $v1 = $r->c([2, 3, 4]);
    my $v2 = $r->sin($v1);
    is_deeply(
      $v2->values,
      [
        sin $v1->values->[0],
        sin $v1->values->[1],
        sin $v1->values->[2]
      ]
    );
  }

  # cos
  {
    my $v1 = $r->c([2, 3, 4]);
    my $v2 = $r->cos($v1);
    is_deeply(
      $v2->values,
      [
        cos $v1->values->[0],
        cos $v1->values->[1],
        cos $v1->values->[2]
      ]
    );
  }

  # tan
  {
    my $v1 = $r->c([2, 3, 4]);
    my $v2 = $r->tan($v1);
    is_deeply(
      $v2->values,
      [
        Math::Trig::tan($v1->values->[0]),
        Math::Trig::tan($v1->values->[1]),
        Math::Trig::tan($v1->values->[2])
      ]
    );
  }

  # sqrt
  {
    my $v1 = $r->c([2, 3, 4]);
    my $v2 = $r->sqrt($v1);
    is_deeply(
      $v2->values,
      [
        sqrt $v1->values->[0],
        sqrt $v1->values->[1],
        sqrt $v1->values->[2]
      ]
    );
  }
  
  # range
  {
    my $v1 = $r->c([1, 2, 3]);
    my $v2 = $r->range($v1);
    is_deeply($v2->values, [1, 3]);
  }
  
  # length
  {
    my $v1 = $r->c([1, 2, 4]);
    my $length = $r->length($v1);
    is($length, 3);
  }

  # sum
  {
    my $v1 = $r->c([1, 2, 3]);
    my $sum = $r->sum($v1);
    is($sum, 6);
  }

  # prod
  {
    my $v1 = $r->c([2, 3, 4]);
    my $prod = $r->prod($v1);
    is($prod, 24);
  }
  
  # mean
  {
    my $v1 = $r->c([1, 2, 3]);
    my $mean = $r->mean($v1);
    is($mean, 2);
  }

  # var
  {
    my $v1 = $r->c([2, 3, 4, 7, 9]);
    my $var = $r->var($v1);
    is($var, 8.5);
  }
  
  # sort
  {
    my $v1 = $r->c([2, 1, 5]);
    my $v1_sorted = $r->sort($v1);
    is_deeply($v1_sorted->values, [1, 2, 5]);
  }
}

# Complex
{
  # new
  {
    my $c1 = Data::R::Complex->new(re => 1, im => 2);
    is($c1->re, 1);
    is($c1->im, 2);
  }
  
  # negation
  {
    my $c1 = Data::R::Complex->new(re => 1, im => 2);
    my $c2 = - $c1;
    is($c2->re, -1);
    is($c2->im, -2);
  }
  
  # add
  {
    my $c1 = Data::R::Complex->new(re => 1, im => 2);
    my $c2 = Data::R::Complex->new(re => 3, im => 4);
    my $c3 = $c1 + $c2;
    is($c3->re, 4);
    is($c3->im, 6);
  }
  
  # add(real number)
  {
    my $c1 = Data::R::Complex->new(re => 1, im => 2);
    my $c2 = $c1 + 3;
    is($c2->re, 4);
    is($c2->im, 2);
  }

  # subtract
  {
    my $c1 = Data::R::Complex->new(re => 1, im => 2);
    my $c2 = Data::R::Complex->new(re => 3, im => 4);
    my $c3 = $c1 - $c2;
    is($c3->re, -2);
    is($c3->im, -2);
  }
  
  # subtract(real number)
  {
    my $c1 = Data::R::Complex->new(re => 1, im => 2);
    my $c2 = $c1 - 3;
    is($c2->re, -2);
    is($c2->im, 2);
  }
  
  # subtract(real number, reverse)
  {
    my $c1 = Data::R::Complex->new(re => 1, im => 2);
    my $c2 = 3 - $c1;
    is($c2->re, 2);
    is($c2->im, -2);
  }
  
  # multiply
  {
    my $c1 = 1 + $r->i * 2;
    my $c2 = 3 + $r->i * 4;
    my $c3 = $c1 * $c2;
    is($c3->re, -5);
    is($c3->im, 10);
  }

  # multiply(real number)
  {
    my $c1 = 1 + $r->i * 2;
    my $c2 = $c1 * 3;
    is($c2->re, 3);
    is($c2->im, 6);
  }
  
  # divide
  {
    my $c1 = 5 - $r->i * 6;
    my $c2 = 3 + $r->i * 2;
    my $c3 = $c1 / $c2;
    is($c3->re, 3/13);
    is($c3->im, -28/13);
  }

  # divide(real number)
  {
    my $c1 = 2 + $r->i * 4;
    my $c2 = $c1 / 2;
    is($c2->re, 1);
    is($c2->im, 2);
  }

  # divide(real number, reverse)
  {
    my $c1 = 3 + $r->i * 2;
    my $c2 = 5 / $c1;
    is($c2->re, 15 / 13);
    is($c2->im, -10 / 13);
  }

  # raise
  {
    my $c1 = 1 + $r->i * 2;
    my $c2 = $c1 ** 3;
    is($c2->re, -11);
    is($c2->im, -2);
  }
}
