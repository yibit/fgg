/* This is monom output for fig 4, i.e.:
 *     go run oopsla20-91/fgg -fgg -monomc=-- fgg/examples/oopsla20/fig4/lists.fgg
 */

//$ go run oopsla20-91/fgg -eval=-1 -v fg/examples/oopsla20/fig7/monom.go

package main;
import "fmt";
type Boolᐸᐳ interface { Not___Bool__() Top; Equal___Bool___Bool__() Top; Cond__a_Any____Branches_α1__α1() Top };
type TTᐸᐳ struct {};
type FFᐸᐳ struct {};
func (this TTᐸᐳ) Not___Bool__() Top { return this };
func (this FFᐸᐳ) Not___Bool__() Top { return this };
func (this TTᐸᐳ) Equal___Bool___Bool__() Top { return this };
func (this FFᐸᐳ) Equal___Bool___Bool__() Top { return this };
func (this TTᐸᐳ) Cond__a_Any____Branches_α1__α1() Top { return this };
func (this FFᐸᐳ) Cond__a_Any____Branches_α1__α1() Top { return this };
type Intᐸᐳ interface { Incᐸᐳ() Intᐸᐳ; Inc___Int__() Top; Decᐸᐳ() Intᐸᐳ; Dec___Int__() Top; Addᐸᐳ(x Intᐸᐳ) Intᐸᐳ; Add___Int___Int__() Top; Gtᐸᐳ(x Intᐸᐳ) Boolᐸᐳ; Gt___Int___Bool__() Top; IsNegᐸᐳ() Boolᐸᐳ; IsNeg___Bool__() Top; Equal___Int___Bool__() Top; EqualZero___Bool__() Top; EqualNonZero___Int___Bool__() Top };
type Zeroᐸᐳ struct {};
func (x0 Zeroᐸᐳ) Incᐸᐳ() Intᐸᐳ { return Posᐸᐳ{x0} };
func (x0 Zeroᐸᐳ) Inc___Int__() Top { return x0 };
func (x0 Zeroᐸᐳ) Decᐸᐳ() Intᐸᐳ { return Negᐸᐳ{x0} };
func (x0 Zeroᐸᐳ) Dec___Int__() Top { return x0 };
func (x0 Zeroᐸᐳ) Addᐸᐳ(x Intᐸᐳ) Intᐸᐳ { return x };
func (x0 Zeroᐸᐳ) Add___Int___Int__() Top { return x0 };
func (x0 Zeroᐸᐳ) Gtᐸᐳ(x Intᐸᐳ) Boolᐸᐳ { return x.IsNegᐸᐳ() };
func (x0 Zeroᐸᐳ) Gt___Int___Bool__() Top { return x0 };
func (x0 Zeroᐸᐳ) IsNegᐸᐳ() Boolᐸᐳ { return FFᐸᐳ{} };
func (x0 Zeroᐸᐳ) IsNeg___Bool__() Top { return x0 };
type Posᐸᐳ struct { dec Intᐸᐳ };
func (x0 Posᐸᐳ) Incᐸᐳ() Intᐸᐳ { return Posᐸᐳ{x0} };
func (x0 Posᐸᐳ) Inc___Int__() Top { return x0 };
func (x0 Posᐸᐳ) Decᐸᐳ() Intᐸᐳ { return x0.dec };
func (x0 Posᐸᐳ) Dec___Int__() Top { return x0 };
func (x0 Posᐸᐳ) Addᐸᐳ(x Intᐸᐳ) Intᐸᐳ { return x0.dec.Addᐸᐳ(x.Incᐸᐳ()) };
func (x0 Posᐸᐳ) Add___Int___Int__() Top { return x0 };
func (x0 Posᐸᐳ) Gtᐸᐳ(x Intᐸᐳ) Boolᐸᐳ { return x0.dec.Gtᐸᐳ(x.Decᐸᐳ()) };
func (x0 Posᐸᐳ) Gt___Int___Bool__() Top { return x0 };
func (x0 Posᐸᐳ) IsNegᐸᐳ() Boolᐸᐳ { return FFᐸᐳ{} };
func (x0 Posᐸᐳ) IsNeg___Bool__() Top { return x0 };
type Negᐸᐳ struct { inc Intᐸᐳ };
func (x0 Negᐸᐳ) Incᐸᐳ() Intᐸᐳ { return x0.inc };
func (x0 Negᐸᐳ) Inc___Int__() Top { return x0 };
func (x0 Negᐸᐳ) Decᐸᐳ() Intᐸᐳ { return Negᐸᐳ{x0} };
func (x0 Negᐸᐳ) Dec___Int__() Top { return x0 };
func (x0 Negᐸᐳ) Addᐸᐳ(x Intᐸᐳ) Intᐸᐳ { return x0.inc.Addᐸᐳ(x.Decᐸᐳ()) };
func (x0 Negᐸᐳ) Add___Int___Int__() Top { return x0 };
func (x0 Negᐸᐳ) Gtᐸᐳ(x Intᐸᐳ) Boolᐸᐳ { return x0.inc.Gtᐸᐳ(x.Incᐸᐳ()) };
func (x0 Negᐸᐳ) Gt___Int___Bool__() Top { return x0 };
func (x0 Negᐸᐳ) IsNegᐸᐳ() Boolᐸᐳ { return TTᐸᐳ{} };
func (x0 Negᐸᐳ) IsNeg___Bool__() Top { return x0 };
type Intsᐸᐳ struct {};
func (d Intsᐸᐳ) _1ᐸᐳ() Intᐸᐳ { return Posᐸᐳ{Zeroᐸᐳ{}} };
func (d Intsᐸᐳ) _1___Int__() Top { return d };
func (d Intsᐸᐳ) _2ᐸᐳ() Intᐸᐳ { return d._1ᐸᐳ().Addᐸᐳ(d._1ᐸᐳ()) };
func (d Intsᐸᐳ) _2___Int__() Top { return d };
func (d Intsᐸᐳ) _3ᐸᐳ() Intᐸᐳ { return d._2ᐸᐳ().Addᐸᐳ(d._1ᐸᐳ()) };
func (d Intsᐸᐳ) _3___Int__() Top { return d };
func (d Intsᐸᐳ) _4ᐸᐳ() Intᐸᐳ { return d._3ᐸᐳ().Addᐸᐳ(d._1ᐸᐳ()) };
func (d Intsᐸᐳ) _4___Int__() Top { return d };
func (d Intsᐸᐳ) _5ᐸᐳ() Intᐸᐳ { return d._4ᐸᐳ().Addᐸᐳ(d._1ᐸᐳ()) };
func (d Intsᐸᐳ) _5___Int__() Top { return d };
func (d Intsᐸᐳ) _6ᐸᐳ() Intᐸᐳ { return d._5ᐸᐳ().Addᐸᐳ(d._1ᐸᐳ()) };
func (d Intsᐸᐳ) _6___Int__() Top { return d };
func (d Intsᐸᐳ) __1ᐸᐳ() Intᐸᐳ { return Negᐸᐳ{Zeroᐸᐳ{}} };
func (d Intsᐸᐳ) __1___Int__() Top { return d };
func (d Intsᐸᐳ) __2ᐸᐳ() Intᐸᐳ { return d.__1ᐸᐳ().Addᐸᐳ(d.__1ᐸᐳ()) };
func (d Intsᐸᐳ) __2___Int__() Top { return d };
func (d Intsᐸᐳ) __3ᐸᐳ() Intᐸᐳ { return d.__2ᐸᐳ().Addᐸᐳ(d.__1ᐸᐳ()) };
func (d Intsᐸᐳ) __3___Int__() Top { return d };
func (d Intsᐸᐳ) __4ᐸᐳ() Intᐸᐳ { return d.__3ᐸᐳ().Addᐸᐳ(d.__1ᐸᐳ()) };
func (d Intsᐸᐳ) __4___Int__() Top { return d };
func (d Intsᐸᐳ) __5ᐸᐳ() Intᐸᐳ { return d.__4ᐸᐳ().Addᐸᐳ(d.__1ᐸᐳ()) };
func (d Intsᐸᐳ) __5___Int__() Top { return d };
type FunctionᐸIntᐸᐳᐨIntᐸᐳᐳ interface { Applyᐸᐳ(x Intᐸᐳ) Intᐸᐳ; Apply___Int___Int__() Top };
type FunctionᐸIntᐸᐳᐨBoolᐸᐳᐳ interface { Applyᐸᐳ(x Intᐸᐳ) Boolᐸᐳ; Apply___Int___Bool__() Top };
type incrᐸᐳ struct { n Intᐸᐳ };
func (this incrᐸᐳ) Applyᐸᐳ(x Intᐸᐳ) Intᐸᐳ { return x.Addᐸᐳ(this.n) };
func (this incrᐸᐳ) Apply___Int___Int__() Top { return this };
type posᐸᐳ struct {};
func (this posᐸᐳ) Applyᐸᐳ(x Intᐸᐳ) Boolᐸᐳ { return x.Gtᐸᐳ(Zeroᐸᐳ{}) };
func (this posᐸᐳ) Apply___Int___Bool__() Top { return this };
func (x0 Zeroᐸᐳ) Equal___Int___Bool__() Top { return x0 };
func (x0 Zeroᐸᐳ) EqualZero___Bool__() Top { return x0 };
func (x0 Zeroᐸᐳ) EqualNonZero___Int___Bool__() Top { return x0 };
func (x0 Posᐸᐳ) Equal___Int___Bool__() Top { return x0 };
func (x0 Posᐸᐳ) EqualZero___Bool__() Top { return x0 };
func (x0 Posᐸᐳ) EqualNonZero___Int___Bool__() Top { return x0 };
func (x0 Negᐸᐳ) Equal___Int___Bool__() Top { return x0 };
func (x0 Negᐸᐳ) EqualZero___Bool__() Top { return x0 };
func (x0 Negᐸᐳ) EqualNonZero___Int___Bool__() Top { return x0 };
type ListᐸIntᐸᐳᐳ interface { MapᐸIntᐸᐳᐳ(f FunctionᐸIntᐸᐳᐨIntᐸᐳᐳ) ListᐸIntᐸᐳᐳ; MapᐸBoolᐸᐳᐳ(f FunctionᐸIntᐸᐳᐨBoolᐸᐳᐳ) ListᐸBoolᐸᐳᐳ; Map__b_Any____Function_Int___α1__List_α1_() Top };
type ListᐸBoolᐸᐳᐳ interface { Map__b_Any____Function_Bool___α1__List_α1_() Top };
type NilᐸIntᐸᐳᐳ struct {};
type NilᐸBoolᐸᐳᐳ struct {};
type ConsᐸIntᐸᐳᐳ struct { head Intᐸᐳ; tail ListᐸIntᐸᐳᐳ };
type ConsᐸBoolᐸᐳᐳ struct { head Boolᐸᐳ; tail ListᐸBoolᐸᐳᐳ };
func (xs NilᐸIntᐸᐳᐳ) MapᐸBoolᐸᐳᐳ(f FunctionᐸIntᐸᐳᐨBoolᐸᐳᐳ) ListᐸBoolᐸᐳᐳ { return NilᐸBoolᐸᐳᐳ{} };
func (xs NilᐸIntᐸᐳᐳ) MapᐸIntᐸᐳᐳ(f FunctionᐸIntᐸᐳᐨIntᐸᐳᐳ) ListᐸIntᐸᐳᐳ { return NilᐸIntᐸᐳᐳ{} };
func (xs NilᐸIntᐸᐳᐳ) Map__b_Any____Function_Int___α1__List_α1_() Top { return xs };
func (xs NilᐸBoolᐸᐳᐳ) Map__b_Any____Function_Bool___α1__List_α1_() Top { return xs };
func (xs ConsᐸIntᐸᐳᐳ) MapᐸIntᐸᐳᐳ(f FunctionᐸIntᐸᐳᐨIntᐸᐳᐳ) ListᐸIntᐸᐳᐳ { return ConsᐸIntᐸᐳᐳ{f.Applyᐸᐳ(xs.head), xs.tail.MapᐸIntᐸᐳᐳ(f)} };
func (xs ConsᐸIntᐸᐳᐳ) MapᐸBoolᐸᐳᐳ(f FunctionᐸIntᐸᐳᐨBoolᐸᐳᐳ) ListᐸBoolᐸᐳᐳ { return ConsᐸBoolᐸᐳᐳ{f.Applyᐸᐳ(xs.head), xs.tail.MapᐸBoolᐸᐳᐳ(f)} };
func (xs ConsᐸBoolᐸᐳᐳ) Map__b_Any____Function_Bool___α1__List_α1_() Top { return xs };
func (xs ConsᐸIntᐸᐳᐳ) Map__b_Any____Function_Int___α1__List_α1_() Top { return xs };
type Top interface {};
func main() { fmt.Printf("%#v", ConsᐸIntᐸᐳᐳ{Intsᐸᐳ{}._3ᐸᐳ(), ConsᐸIntᐸᐳᐳ{Intsᐸᐳ{}._6ᐸᐳ(), NilᐸIntᐸᐳᐳ{}}}.MapᐸIntᐸᐳᐳ(incrᐸᐳ{Intsᐸᐳ{}.__5ᐸᐳ()}).MapᐸBoolᐸᐳᐳ(posᐸᐳ{})) }