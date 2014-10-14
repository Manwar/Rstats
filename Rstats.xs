#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

/* avoid symbol collisions*/
#undef init_tm
#undef do_open
#undef do_close
#ifdef ENTER
#undef ENTER
#endif

/* C library */
#include <math.h>

/* C++ library */
#include <vector>
#include <iostream>

#include "Rstats.h"

Rstats::PerlAPI* p = new Rstats::PerlAPI;

MODULE = Rstats::ElementXS PACKAGE = Rstats::ElementXS

void
type(...)
  PPCODE:
{
  Rstats::Element* self = p->to_c_obj<Rstats::Element*>(ST(0));
  
  // Type
  Rstats::ElementType::Enum type = self->type;
  SV* type_sv;
  if (type == Rstats::ElementType::NA) {
    type_sv = p->new_sv("na");
  }
  else if (type == Rstats::ElementType::LOGICAL) {
    type_sv = p->new_sv("logical");
  }
  else if (type == Rstats::ElementType::INTEGER) {
    type_sv = p->new_sv("integer");
  }
  else if (type == Rstats::ElementType::DOUBLE) {
    type_sv = p->new_sv("double");
  }
  else if (type == Rstats::ElementType::COMPLEX) {
    type_sv = p->new_sv("complex");
  }
  else if (type == Rstats::ElementType::CHARACTER) {
    type_sv = p->new_sv("character");
  }
  else if (type == Rstats::ElementType::UNKNOWN) {
    type_sv = p->new_sv("unknown");
  }
  
  XPUSHs(type_sv);
  XSRETURN(1);
}

void
iv(...)
  PPCODE:
{
  Rstats::Element* self = p->to_c_obj<Rstats::Element*>(ST(0));
  
  I32 iv = self->iv;
  
  XPUSHs(p->new_sv(iv));
  XSRETURN(1);
}

void
dv(...)
  PPCODE:
{
  Rstats::Element* self = p->to_c_obj<Rstats::Element*>(ST(0));
  
  double dv = self->dv;
  
  XPUSHs(p->new_sv(dv));
  XSRETURN(1);
}

void
cv(...)
  PPCODE:
{
  Rstats::Element* self = p->to_c_obj<Rstats::Element*>(ST(0));
  
  SV* chv_sv = p->new_sv(self->chv);
  
  XPUSHs(chv_sv);
  XSRETURN(1);
}

void
re(...)
  PPCODE:
{
  Rstats::Element* self = p->to_c_obj<Rstats::Element*>(ST(0));
  
  double re = ((std::complex<double>*)self->pv)->real();
  
  XPUSHs(p->new_sv(re));
  XSRETURN(1);
}

void
im(...)
  PPCODE:
{
  Rstats::Element* self = p->to_c_obj<Rstats::Element*>(ST(0));
  
  double im = ((std::complex<double>*)self->pv)->imag();
  
  XPUSHs(p->new_sv(im));
  XSRETURN(1);
}

void
flag(...)
  PPCODE:
{
  Rstats::Element* self = p->to_c_obj<Rstats::Element*>(ST(0));
  
  XSRETURN(0);
}

void
DESTROY(...)
  PPCODE:
{
  Rstats::Element* self = p->to_c_obj<Rstats::Element*>(ST(0));
  if (self->type == Rstats::ElementType::COMPLEX) {
    delete (std::complex<double>*)self->pv;
  }
  else if (self->type == Rstats::ElementType::CHARACTER) {
    delete self->chv;
  }
  delete self;
}

MODULE = Rstats::ElementFunc PACKAGE = Rstats::ElementFunc

void
character_xs(...)
  PPCODE:
{
  SV* value_sv = ST(0);
  char* chv = p->pv(value_sv);
  
  Rstats::Element* element = new Rstats::Element;
  element->chv = chv;
  element->type = Rstats::ElementType::CHARACTER;
  
  SV* element_obj = p->to_perl_obj(element, "Rstats::ElementXS");
  
  XPUSHs(element_obj);
  XSRETURN(1);
}

void
complex_xs(...)
  PPCODE:
{
  SV* re_sv = ST(0);
  SV* im_sv = ST(1);

  double re = p->nv(re_sv);
  double im = p->nv(im_sv);
  
  std::complex<double>* z = new std::complex<double>(re, im);
  
  Rstats::Element* element = new Rstats::Element;
  element->pv = (void*)z;
  element->type = Rstats::ElementType::COMPLEX;
  
  SV* element_obj = p->to_perl_obj(element, "Rstats::ElementXS");
  
  XPUSHs(element_obj);
  XSRETURN(1);
}

void
logical_xs(...)
  PPCODE:
{
  SV* value_sv = ST(0);
  I32 iv = p->iv(value_sv);
  
  Rstats::Element* element = new Rstats::Element;
  element->iv = iv;
  element->type = Rstats::ElementType::LOGICAL;
  
  SV* element_obj = p->to_perl_obj(element, "Rstats::ElementXS");
  
  XPUSHs(element_obj);
  XSRETURN(1);
}

void
integer_xs(...)
  PPCODE:
{
  SV* value_sv = ST(0);
  I32 iv = p->iv(value_sv);
  
  Rstats::Element* element = new Rstats::Element;
  element->iv = iv;
  element->type = Rstats::ElementType::INTEGER;
  
  SV* element_obj = p->to_perl_obj(element, "Rstats::ElementXS");
  
  XPUSHs(element_obj);
  XSRETURN(1);
}

void
double_xs(...)
  PPCODE:
{
  SV* value_sv = ST(0);
  double dv = p->nv(value_sv);
  
  Rstats::Element* element = new Rstats::Element;
  element->dv = dv;
  element->type = Rstats::ElementType::DOUBLE;
  
  SV* element_obj = p->to_perl_obj(element, "Rstats::ElementXS");

  XPUSHs(element_obj);
  XSRETURN(1);
}

MODULE = Rstats::Util PACKAGE = Rstats::Util

void
cross_product(...)
  PPCODE:
{
  SV* values_sv = ST(0);
  
  I32 values_length = p->length(values_sv);
  SV* idxs_sv = p->new_av_ref();
  for (I32 i = 0; i < values_length; i++) {
    p->push(idxs_sv, p->new_sv(0)); 
  }
  
  SV* idx_idx_sv = p->new_av_ref();
  for (I32 i = 0; i < values_length; i++) {
    p->push(idx_idx_sv, p->new_sv(i));
  }
  
  SV* x1_sv = p->new_av_ref();
  for (I32 i = 0; i < values_length; i++) {
    SV* value_sv = p->av_get(values_sv, i);
    p->push(x1_sv, p->av_get(value_sv, 0));
  }

  SV* result_sv = p->new_av_ref();
  p->push(result_sv, p->copy_av(x1_sv));
  I32 end_loop = 0;
  while (1) {
    for (I32 i = 0; i < values_length; i++) {
      
      if (p->iv(p->av_get(idxs_sv, i)) < p->length(p->av_get(values_sv, i)) - 1) {
        
        SV* idxs_tmp = p->av_get(idxs_sv, i);
        Perl_sv_inc(idxs_tmp);
        p->av_set(x1_sv, i, p->av_get(p->av_get(values_sv, i), idxs_tmp));
        
        p->push(result_sv, p->copy_av(x1_sv));
        
        break;
      }
      
      if (i == p->iv(p->av_get(idx_idx_sv, values_length - 1))) {
        end_loop = 1;
        break;
      }
      
      p->av_set(idxs_sv, i, p->new_sv(0));
      p->av_set(x1_sv, i, p->av_get(p->av_get(values_sv, i), 0));
    }
    if (end_loop) {
      break;
    }
  }

  XPUSHs(result_sv);
  XSRETURN(1);
}

void
pos_to_index(...)
  PPCODE:
{
  SV* pos_sv = ST(0);
  SV* dim_sv = ST(1);
  
  SV* index_sv = p->new_av_ref();
  I32 pos = p->iv(pos_sv);
  I32 before_dim_product = 1;
  for (I32 i = 0; i < p->length(p->av_deref(dim_sv)); i++) {
    before_dim_product *= p->iv(p->av_get(dim_sv, i));
  }
  
  for (I32 i = p->length(p->av_deref(dim_sv)) - 1; i >= 0; i--) {
    I32 dim_product = 1;
    for (I32 k = 0; k < i; k++) {
      dim_product *= p->iv(p->av_get(dim_sv, k));
    }
    
    I32 reminder = pos % before_dim_product;
    I32 quotient = (int)(reminder / dim_product);
    
    p->unshift(index_sv, p->new_sv(quotient + 1));
    before_dim_product = dim_product;
  }
  
  XPUSHs(index_sv);
  XSRETURN(1);
}

void
index_to_pos(...)
  PPCODE :
{
  SV* index_sv =ST(0);
  SV* dim_values_sv = ST(1);
  
  U32 pos = 0;
  for (U32 i = 0; i < p->length(p->av_deref(dim_values_sv)); i++) {
    if (i > 0) {
      U32 tmp = 1;
      for (U32 k = 0; k < i; k++) {
        tmp *= p->uv(p->av_get(dim_values_sv, k));
      }
      pos += tmp * (p->uv(p->av_get(index_sv, i)) - 1);
    }
    else {
      pos += p->uv(p->av_get(index_sv, i));
    }
  }
  
  SV* pos_sv = p->new_sv(pos - 1);
  
  XPUSHs(pos_sv);
  XSRETURN(1);
}

MODULE = Rstats PACKAGE = Rstats
