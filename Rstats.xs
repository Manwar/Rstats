/* Rstats headers */
#include "Rstats.h"

/* Shortcut of return sv */
#define return_sv(x) XPUSHs(x); XSRETURN(1);

MODULE = Rstats::Func PACKAGE = Rstats::Func

SV* sin(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::sin(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* atan2(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::atan2(sv_r, ST(1), ST(2));
  
  return_sv(sv_x_out);
}

SV* or(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x1 = Rstats::Func::to_c(sv_r, ST(1));
  SV* sv_x2 = Rstats::Func::to_c(sv_r, ST(2));
  
  SV* sv_x_out = Rstats::Func::Or(sv_r, sv_x1, sv_x2);
  
  return_sv(sv_x_out);
}

SV* add(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x1 = Rstats::Func::to_c(sv_r, ST(1));
  SV* sv_x2 = Rstats::Func::to_c(sv_r, ST(2));
  
  SV* sv_x_out = Rstats::Func::add(sv_r, sv_x1, sv_x2);
  
  return_sv(sv_x_out);
}

SV* subtract(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x1 = Rstats::Func::to_c(sv_r, ST(1));
  SV* sv_x2 = Rstats::Func::to_c(sv_r, ST(2));
  
  SV* sv_x_out = Rstats::Func::subtract(sv_r, sv_x1, sv_x2);
  
  return_sv(sv_x_out);
}

SV* multiply(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x1 = Rstats::Func::to_c(sv_r, ST(1));
  SV* sv_x2 = Rstats::Func::to_c(sv_r, ST(2));
  
  SV* sv_x_out = Rstats::Func::multiply(sv_r, sv_x1, sv_x2);
  
  return_sv(sv_x_out);
}

SV* divide(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x1 = Rstats::Func::to_c(sv_r, ST(1));
  SV* sv_x2 = Rstats::Func::to_c(sv_r, ST(2));
  
  SV* sv_x_out = Rstats::Func::divide(sv_r, sv_x1, sv_x2);
  
  return_sv(sv_x_out);
}

SV* remainder(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x1 = Rstats::Func::to_c(sv_r, ST(1));
  SV* sv_x2 = Rstats::Func::to_c(sv_r, ST(2));
  
  SV* sv_x_out = Rstats::Func::remainder(sv_r, sv_x1, sv_x2);
  
  return_sv(sv_x_out);
}

SV* pow(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x1 = Rstats::Func::to_c(sv_r, ST(1));
  SV* sv_x2 = Rstats::Func::to_c(sv_r, ST(2));
  
  SV* sv_x_out = Rstats::Func::pow(sv_r, sv_x1, sv_x2);
  
  return_sv(sv_x_out);
}

SV* less_than(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x1 = Rstats::Func::to_c(sv_r, ST(1));
  SV* sv_x2 = Rstats::Func::to_c(sv_r, ST(2));
  
  SV* sv_x_out = Rstats::Func::less_than(sv_r, sv_x1, sv_x2);
  
  return_sv(sv_x_out);
}

SV* less_than_or_equal(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x1 = Rstats::Func::to_c(sv_r, ST(1));
  SV* sv_x2 = Rstats::Func::to_c(sv_r, ST(2));
  
  SV* sv_x_out = Rstats::Func::less_than_or_equal(sv_r, sv_x1, sv_x2);
  
  return_sv(sv_x_out);
}

SV* more_than(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x1 = Rstats::Func::to_c(sv_r, ST(1));
  SV* sv_x2 = Rstats::Func::to_c(sv_r, ST(2));
  
  SV* sv_x_out = Rstats::Func::more_than(sv_r, sv_x1, sv_x2);
  
  return_sv(sv_x_out);
}

SV* more_than_or_equal(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x1 = Rstats::Func::to_c(sv_r, ST(1));
  SV* sv_x2 = Rstats::Func::to_c(sv_r, ST(2));
  
  SV* sv_x_out = Rstats::Func::more_than_or_equal(sv_r, sv_x1, sv_x2);
  
  return_sv(sv_x_out);
}

SV* equal(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x1 = Rstats::Func::to_c(sv_r, ST(1));
  SV* sv_x2 = Rstats::Func::to_c(sv_r, ST(2));
  
  SV* sv_x_out = Rstats::Func::equal(sv_r, sv_x1, sv_x2);
  
  return_sv(sv_x_out);
}

SV* not_equal(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x1 = Rstats::Func::to_c(sv_r, ST(1));
  SV* sv_x2 = Rstats::Func::to_c(sv_r, ST(2));
  
  SV* sv_x_out = Rstats::Func::not_equal(sv_r, sv_x1, sv_x2);
  
  return_sv(sv_x_out);
}

SV* and(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x1 = Rstats::Func::to_c(sv_r, ST(1));
  SV* sv_x2 = Rstats::Func::to_c(sv_r, ST(2));
  
  SV* sv_x_out = Rstats::Func::And(sv_r, sv_x1, sv_x2);
  
  return_sv(sv_x_out);
}

SV* first_value(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_value = Rstats::Func::create_sv_value(sv_r, ST(1), 0);
  
  return_sv(sv_value);
}

SV* tanh(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::tanh(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* Mod(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::Mod(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* Arg(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::Arg(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* Conj(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::Conj(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* acosh(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::acosh(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* Re(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::Re(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* Im(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::Im(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* abs(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::abs(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* acos(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::acos(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* asin(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::asin(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* asinh(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::asinh(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* atan(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::atan(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* atanh(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::atanh(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* cos(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::cos(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* cosh(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::cosh(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* cumsum(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::cumsum(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* cumprod(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::cumprod(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* exp(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::exp(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* expm1(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::expm1(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* log(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::log(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* logb(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::logb(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* log2(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::log2(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* log10(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::log10(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* prod(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::prod(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* sinh(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::sinh(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* sqrt(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::sqrt(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* tan(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::tan(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* sum(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::sum(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* negation(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::negation(sv_r, ST(1));
  
  return_sv(sv_x_out);
}


SV* type(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x_out = Rstats::Func::type(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* is_numeric(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x_out = Rstats::Func::is_numeric(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* is_array(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x_out = Rstats::Func::is_array(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* is_matrix(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x_out = Rstats::Func::is_matrix(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* dim(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  
  if (items > 2) {
    SV* sv_x_dim = ST(2);
    Rstats::Func::dim(sv_r, sv_x1, sv_x_dim);
    return_sv(sv_r);
  }
  else {
    SV* sv_x_dim = Rstats::Func::dim(sv_r, sv_x1);
    return_sv(sv_x_dim);
  }
}

SV* values(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x_out = Rstats::Func::values(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* length_value(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x_out = Rstats::Func::length_value(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* is_vector(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x_out = Rstats::Func::is_vector(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* is_null(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x_out = Rstats::Func::is_null(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* pi(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = Rstats::Func::pi(sv_r);
  
  return_sv(sv_x1);
}

SV* NULL(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = Rstats::Func::new_null(sv_r);
  
  return_sv(sv_x1);
}

SV* NA(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = Rstats::Func::new_na(sv_r);
  
  return_sv(sv_x1);
}

SV* NaN(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = Rstats::Func::new_nan(sv_r);
  
  return_sv(sv_x1);
}

SV* Inf(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = Rstats::Func::new_inf(sv_r);
  
  return_sv(sv_x1);
}

SV* FALSE(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = Rstats::Func::new_false(sv_r);
  
  return_sv(sv_x1);
}

SV* F(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = Rstats::Func::new_false(sv_r);
  
  return_sv(sv_x1);
}

SV* F_(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = Rstats::Func::new_false(sv_r);
  
  return_sv(sv_x1);
}

SV* TRUE(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = Rstats::Func::new_true(sv_r);
  
  return_sv(sv_x1);
}

SV* T(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = Rstats::Func::new_true(sv_r);
  
  return_sv(sv_x1);
}

SV* T_(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = Rstats::Func::new_true(sv_r);
  
  return_sv(sv_x1);
}

SV* args_h(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_names = ST(1);
  SV* sv_args_h = Rstats::pl_new_avrv();
  
  for (IV i = 2; i < items; i++) {
    Rstats::pl_av_push(sv_args_h, ST(i));
  }
  
  SV* sv_opt = Rstats::Func::args_h(sv_r, sv_names, sv_args_h);
  
  return_sv(sv_opt);
}

SV* to_c(...)
  PPCODE:
{
  SV* sv_x = Rstats::Func::to_c(ST(0), ST(1));
  
  return_sv(sv_x);
}

SV* c_(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_values;
  if (sv_derived_from(ST(1), "ARRAY")) {
    sv_values = ST(1);
  }
  else {
    sv_values = Rstats::pl_new_avrv();
    for (IV i = 1; i < items; i++) {
      Rstats::pl_av_push(sv_values, ST(i));
    }
  }
  
  SV* sv_x1 = Rstats::Func::c(sv_r, sv_values);
  
  return_sv(sv_x1);
}

SV* c_character(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_values;
  if (sv_derived_from(ST(1), "ARRAY")) {
    sv_values = ST(1);
  }
  else {
    sv_values = Rstats::pl_new_avrv();
  
    for (IV i = 1; i < items; i++) {
      Rstats::pl_av_push(sv_values, ST(i));
    }
  }

  SV* sv_x1 = Rstats::Func::c_character(sv_r, sv_values);
  
  return_sv(sv_x1);
}

SV* c_double(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_values;
  if (sv_derived_from(ST(1), "ARRAY")) {
    sv_values = ST(1);
  }
  else {
    sv_values = Rstats::pl_new_avrv();
  
    for (IV i = 1; i < items; i++) {
      Rstats::pl_av_push(sv_values, ST(i));
    }
  }

  SV* sv_x1 = Rstats::Func::c_double(sv_r, sv_values);
  
  return_sv(sv_x1);
}

SV* c_complex(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_values;
  if (sv_derived_from(ST(1), "ARRAY")) {
    sv_values = ST(1);
  }
  else {
    sv_values = Rstats::pl_new_avrv();
  
    for (IV i = 1; i < items; i++) {
      Rstats::pl_av_push(sv_values, ST(i));
    }
  }

  SV* sv_x1 = Rstats::Func::c_complex(sv_r, sv_values);
  
  return_sv(sv_x1);
}

SV* c_integer(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_values;
  if (sv_derived_from(ST(1), "ARRAY")) {
    sv_values = ST(1);
  }
  else {
    sv_values = Rstats::pl_new_avrv();
  
    for (IV i = 1; i < items; i++) {
      Rstats::pl_av_push(sv_values, ST(i));
    }
  }

  SV* sv_x1 = Rstats::Func::c_integer(sv_r, sv_values);
  
  return_sv(sv_x1);
}

SV* c_logical(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_values;
  if (sv_derived_from(ST(1), "ARRAY")) {
    sv_values = ST(1);
  }
  else {
    sv_values = Rstats::pl_new_avrv();
  
    for (IV i = 1; i < items; i++) {
      Rstats::pl_av_push(sv_values, ST(i));
    }
  }

  SV* sv_x1 = Rstats::Func::c_logical(sv_r, sv_values);
  
  return_sv(sv_x1);
}

SV* is_double(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x_out = Rstats::Func::is_double(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* is_integer(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x_out = Rstats::Func::is_integer(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* is_complex(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x_out = Rstats::Func::is_complex(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* is_character(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x_out = Rstats::Func::is_character(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* is_logical(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x_out = Rstats::Func::is_logical(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* is_data_frame(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x_out = Rstats::Func::is_data_frame(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* is_list(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x_out = Rstats::Func::is_list(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* as_vector(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x_out = Rstats::Func::as_vector(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* new_data_frame(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = Rstats::Func::new_data_frame(sv_r);
  
  return_sv(sv_x1);
}

SV* new_list(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = Rstats::Func::new_list(sv_r);
  
  return_sv(sv_x1);
}

SV* copy_attrs_to(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x2 = ST(2);
  SV* sv_opt = items > 3 ? ST(3) : &PL_sv_undef;
  
  Rstats::Func::copy_attrs_to(sv_r, sv_x1, sv_x2, sv_opt);
  
  return_sv(sv_r);
}

SV* as_integer(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x_out = Rstats::Func::as_integer(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* as_logical(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x_out = Rstats::Func::as_logical(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* as_complex(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x_out = Rstats::Func::as_complex(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* as_double(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x_out = Rstats::Func::as_double(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* as_numeric(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x_out = Rstats::Func::as_numeric(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* is_finite(...)
  PPCODE:
{
  SV* sv_r = ST(0);

  SV* sv_x_out = Rstats::Func::is_finite(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* is_infinite(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::is_infinite(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* is_nan(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  SV* sv_x_out = Rstats::Func::is_nan(sv_r, ST(1));
  
  return_sv(sv_x_out);
}

SV* is_na(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x_out = Rstats::Func::is_na(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* class(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  if (items > 2) {
    SV* sv_x2 = ST(2);
    Rstats::Func::Class(sv_r, sv_x1, sv_x2);
    return_sv(sv_r);
  }
  else {
    SV* sv_x_out = Rstats::Func::Class(sv_r, sv_x1);
    return_sv(sv_x_out);
  }
}

SV* is_factor(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x_out = Rstats::Func::is_factor(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* is_ordered(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x_out = Rstats::Func::is_ordered(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* clone(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x_out = Rstats::Func::clone(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* dim_as_array(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  SV* sv_x_out = Rstats::Func::dim_as_array(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* decompose(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* x1 = ST(1);
  SV* sv_decomposed = Rstats::Func::decompose(sv_r, x1);
  return_sv(sv_decomposed);
}

SV* compose(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_type = ST(1);
  SV* sv_x1 = ST(2);

  SV* sv_composed = Rstats::Func::compose(sv_r, sv_type, sv_x1);
  return_sv(sv_composed);
}

SV* array(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  
  // Args
  SV* sv_args = Rstats::pl_new_avrv();
  for (IV i = 1; i < items; i++) {
    Rstats::pl_av_push(sv_args, ST(i));
  }
  SV* sv_names = Rstats::pl_new_avrv();
  Rstats::pl_av_push(sv_names, Rstats::pl_new_sv_pv("x"));
  Rstats::pl_av_push(sv_names, Rstats::pl_new_sv_pv("dim"));
  SV* sv_args_h = Rstats::Func::args_h(sv_r, sv_names, sv_args);
  
  SV* sv_result = Rstats::Func::array_with_opt(sv_r, sv_args_h);
  return_sv(sv_result);
}

SV* as_array(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  
  SV* sv_x_out = Rstats::Func::as_array(sv_r, sv_x1);
  return_sv(sv_x_out);
}

SV* levels(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  if (items > 2) {
    SV* sv_x2 = ST(2);
    Rstats::Func::levels(sv_r, sv_x1, sv_x2);
    return_sv(sv_r);
  }
  else {
    SV* sv_x_out = Rstats::Func::levels(sv_r, sv_x1);
    return_sv(sv_x_out);
  }
}

SV* as_character(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  
  SV* sv_x_out = Rstats::Func::as_character(sv_r, sv_x1);
  return_sv(sv_x_out);
}

SV* mode(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  if (items > 2) {
    SV* sv_x_mode = ST(2);
    Rstats::Func::mode(sv_r, sv_x1, sv_x_mode);
      
    return_sv(sv_r);
  }
  else {
    SV* sv_x_mode = Rstats::Func::mode(sv_r, sv_x1);
    return_sv(sv_x_mode);
  }
}

SV* as(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_type = ST(1);
  SV* sv_x1 = ST(2);
  
  SV* sv_x_out = Rstats::Func::as(sv_r, sv_type, sv_x1);
  
  return_sv(sv_x_out);
}

SV* length(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  
  SV* sv_x_out = Rstats::Func::length(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* names(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  if (items > 2) {
    SV* sv_x_names = ST(2);
    Rstats::Func::names(sv_r, sv_x1, sv_x_names);
      
    return_sv(sv_r);
  }
  else {
    SV* sv_x_names = Rstats::Func::names(sv_r, sv_x1);
    return_sv(sv_x_names);
  }
}

SV* typeof(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  
  SV* sv_x_out = Rstats::Func::Typeof(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* get_type(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_x1 = ST(1);
  
  SV* sv_x_out = Rstats::Func::get_type_sv(sv_r, sv_x1);
  
  return_sv(sv_x_out);
}

SV* upgrade_type(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_xs = ST(1);
  
  SV* sv_new_xs = Rstats::Func::upgrade_type_avrv(sv_r, sv_xs);
  
  return_sv(sv_new_xs);
}

SV* upgrade_length(...)
  PPCODE:
{
  SV* sv_r = ST(0);
  SV* sv_xs = ST(1);
  
  SV* sv_new_xs = Rstats::Func::upgrade_length_avrv(sv_r, sv_xs);
  
  return_sv(sv_new_xs);
}

MODULE = Rstats::Vector PACKAGE = Rstats::Vector

SV* DESTROY(...)
  PPCODE:
{
  Rstats::Vector* self = Rstats::pl_to_c_obj<Rstats::Vector*>(ST(0));

  Rstats::VectorFunc::delete_vector(self);
}

MODULE = Rstats::Util PACKAGE = Rstats::Util

SV* pi(...)
  PPCODE:
{
  NV pi = Rstats::Util::pi();
  SV* sv_pi = Rstats::pl_new_sv_nv(pi);
  
  return_sv(sv_pi);
}

SV* is_perl_number(...)
  PPCODE:
{
  SV* sv_str = ST(0);
  IV ret = Rstats::Util::is_perl_number(sv_str);
  SV* sv_ret = ret ? Rstats::pl_new_sv_iv(1) : &PL_sv_undef;
  return_sv(sv_ret);
}

SV* looks_like_integer(...)
  PPCODE:
{
  SV* sv_str = ST(0);
  SV* sv_ret = Rstats::Util::looks_like_integer(sv_str);
  return_sv(sv_ret);
}

SV* looks_like_double(...)
  PPCODE:
{
  SV* sv_str = ST(0);
  SV* sv_ret = Rstats::Util::looks_like_double(sv_str);
  return_sv(sv_ret);
}

SV* looks_like_na(...)
  PPCODE:
{
  SV* sv_str = ST(0);
  SV* sv_ret = Rstats::Util::looks_like_na(sv_str);
  return_sv(sv_ret);
}

SV* looks_like_logical(...)
  PPCODE:
{
  SV* sv_str = ST(0);
  SV* sv_ret = Rstats::Util::looks_like_logical(sv_str);
  return_sv(sv_ret);
}

SV* looks_like_complex(...)
  PPCODE:
{
  SV* sv_str = ST(0);
  SV* sv_ret = Rstats::Util::looks_like_complex(sv_str);
  return_sv(sv_ret);
}

SV* cross_product(...)
  PPCODE:
{
  SV* sv_ret = Rstats::Util::cross_product(ST(0));
  return_sv(sv_ret);
}

SV* pos_to_index(...)
  PPCODE:
{
  SV* sv_ret = Rstats::Util::pos_to_index(ST(0), ST(1));
  return_sv(sv_ret);
}

SV* index_to_pos(...)
  PPCODE:
{
  SV* sv_ret = Rstats::Util::index_to_pos(ST(0), ST(1));
  return_sv(sv_ret);
}

MODULE = Rstats PACKAGE = Rstats
