package fg

import "fmt"
import "strings"

type Name = string
type Type Name
type Env map[Name]Type

func fields(ds []TypeLit, t_S Type) []FieldDecl {
	for _, v := range ds {
		s, ok := v.(TStruct)
		if ok && s.typ == t_S {
			return s.elems
		}
	}
	panic("Unknown type: " + t_S.String())
}

// t2 <: t1
func (t1 Type) Impl(t2 Type) bool {
	return true // TODO: need ~D param, methods aux
}

func (t Type) String() string {
	return string(t)
}

type FGNode interface {
	String() string
}

type FGProgram struct {
	decls []TypeLit
	body  Expr
}

func (p FGProgram) Ok() bool {
	var gamma Env
	p.body.Typing(p.decls, gamma)
	return true
}

func (p FGProgram) String() string {
	var b strings.Builder
	b.WriteString("package main;\n")
	for _, v := range p.decls {
		b.WriteString(v.String())
		b.WriteString(";\n")
	}
	b.WriteString("func main() { _ = ")
	b.WriteString(p.body.String())
	b.WriteString(" }")
	return b.String()
}

var _ FGNode = FGProgram{}

type TypeLit interface {
	FGNode
	GetType() Type
}

type TStruct struct {
	typ   Type
	elems []FieldDecl
}

func (s TStruct) GetType() Type {
	return s.typ
}

func (s TStruct) String() string {
	var b strings.Builder
	b.WriteString("type ")
	b.WriteString(s.typ.String())
	b.WriteString(" struct {")
	if len(s.elems) > 0 {
		b.WriteString(" ")
		b.WriteString(s.elems[0].String())
		for _, v := range s.elems[1:] {
			b.WriteString("; ")
			b.WriteString(v.String())
		}
		b.WriteString(" ")
	}
	b.WriteString("}")
	return b.String()
}

var _ TypeLit = TStruct{}

type FieldDecl struct {
	field Name
	typ   Type
}

func (fd FieldDecl) String() string {
	return fd.field + " " + fd.typ.String()
}

var _ FGNode = FieldDecl{}

type Expr interface {
	FGNode
	Subs(map[Variable]Expr) Expr
	Eval() Expr
	Typing(ds []TypeLit, gamma Env) Type
}

type Variable struct {
	n Name
}

func (this Variable) Subs(m map[Variable]Expr) Expr {
	res, ok := m[this]
	if !ok {
		panic("Unknown var: " + this.String())
	}
	return res
}

func (this Variable) Eval() Expr {
	panic(this.n)
}

func (v Variable) Typing(ds []TypeLit, gamma Env) Type {
	res, ok := gamma[v.n]
	if !ok {
		panic("Var not in env: " + v.String())
	}
	return res
}

func (this Variable) String() string {
	return this.n
}

var _ Expr = Variable{}

type StructLit struct {
	t  Type
	es []Expr
}

func (this StructLit) Subs(m map[Variable]Expr) Expr {
	return this
}

func (this StructLit) Eval() Expr {
	return this
}

func (s StructLit) Typing(ds []TypeLit, gamma Env) Type {
	fs := fields(ds, s.t)
	if len(s.es) != len(fs) {
		panic("Arity mismatch: found=" +
			strings.Join(strings.Split(fmt.Sprint(s.es), " "), ", ") +
			", expected=" +
			strings.Join(strings.Split(fmt.Sprint(fs), " "), ", ")) // FIXME: bad split, " ", between f and t as well as fd's
	}
	for i := 0; i < len(s.es); i++ {
		t := s.es[i].Typing(ds, gamma)
		u := fs[i].typ
		if !u.Impl(t) {
			panic("Arg expr must impl field type: arg=" + t.String() + " field=" + u.String())
		}
	}
	return s.t
}

func (this StructLit) String() string {
	var sb strings.Builder
	sb.WriteString(this.t.String())
	sb.WriteString("{")
	sb.WriteString(strings.Trim(strings.Join(strings.Split(fmt.Sprint(this.es), " "), ", "), "[]"))
	sb.WriteString("}")
	return sb.String()
}

var _ Expr = StructLit{}

/*
type Select struct {
	e Expr
	f Name
}

func (this Select) Eval() Expr {

}

type Call struct {
	recv Expr
	m    Name
	args []Expr
}

func (this Call) Eval() Expr {

}

type Assert struct {
	e Expr
	t Name
}

func (this assert) Eval() Expr {

}
*/
