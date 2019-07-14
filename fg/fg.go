package fg

import "fmt"
import "strings"

type Name = string
type Type Name
type Env map[Name]Type

func fields(ds []Decl, t_S Type) []FieldDecl {
	for _, v := range ds {
		s, ok := v.(TStruct)
		if ok && s.t == t_S {
			return s.fds
		}
	}
	panic("Unknown type: " + t_S.String())
}

// t <: t0
func (t0 Type) Impl(ds []Decl, t Type) bool {
	return true // TODO: meth ds, sigs, methods aux
}

func (t Type) String() string {
	return string(t)
}

type FGNode interface {
	String() string
}

type FGProgram struct {
	ds []Decl
	e  Expr
}

var _ FGNode = FGProgram{}

func (p FGProgram) Ok() bool {
	var gamma Env
	p.e.Typing(p.ds, gamma)
	return true
}

func (p FGProgram) String() string {
	var b strings.Builder
	b.WriteString("package main;\n")
	for _, v := range p.ds {
		b.WriteString(v.String())
		b.WriteString(";\n")
	}
	b.WriteString("func main() { _ = ")
	b.WriteString(p.e.String())
	b.WriteString(" }")
	return b.String()
}

type Decl interface {
	FGNode
}

type TDecl interface {
	Decl
	GetType() Type
}

type MDecl struct {
	recv ParamDecl
	m    Name
	ps   []ParamDecl
	t    Type
	e    Expr
}

var _ Decl = MDecl{}

func (m MDecl) String() string {
	var b strings.Builder
	b.WriteString("func (")
	b.WriteString(m.recv.String())
	b.WriteString(") ")
	b.WriteString(m.m)
	b.WriteString("(")
	if len(m.ps) > 0 {
		b.WriteString(m.ps[0].String())
		for _, v := range m.ps[1:] {
			b.WriteString(", ")
			b.WriteString(v.String())
		}
	}
	b.WriteString(") ")
	b.WriteString(m.t.String())
	b.WriteString("{ return ")
	b.WriteString(m.e.String())
	b.WriteString(" }")
	return b.String()
}

// Cf. FieldDecl
type ParamDecl struct {
	x Name
	t Type
}

var _ FGNode = ParamDecl{}

func (p ParamDecl) String() string {
	return p.x + " " + p.t.String()
}

type TStruct struct {
	t   Type
	fds []FieldDecl
}

var _ TDecl = TStruct{}

func (s TStruct) GetType() Type {
	return s.t
}

func (s TStruct) String() string {
	var b strings.Builder
	b.WriteString("type ")
	b.WriteString(s.t.String())
	b.WriteString(" struct {")
	if len(s.fds) > 0 {
		b.WriteString(" ")
		b.WriteString(s.fds[0].String())
		for _, v := range s.fds[1:] {
			b.WriteString("; ")
			b.WriteString(v.String())
		}
		b.WriteString(" ")
	}
	b.WriteString("}")
	return b.String()
}

type FieldDecl struct {
	f Name
	t Type
}

var _ FGNode = FieldDecl{}

func (fd FieldDecl) String() string {
	return fd.f + " " + fd.t.String()
}

type Expr interface {
	FGNode
	Subs(map[Variable]Expr) Expr
	Eval() Expr
	Typing(ds []Decl, gamma Env) Type
}

type Variable struct {
	id Name
}

var _ Expr = Variable{}

func (v Variable) Subs(m map[Variable]Expr) Expr {
	res, ok := m[v]
	if !ok {
		panic("Unknown var: " + v.String())
	}
	return res
}

func (v Variable) Eval() Expr {
	panic(v.id)
}

func (v Variable) Typing(ds []Decl, gamma Env) Type {
	res, ok := gamma[v.id]
	if !ok {
		panic("Var not in env: " + v.String())
	}
	return res
}

func (v Variable) String() string {
	return v.id
}

type StructLit struct {
	t  Type
	es []Expr
}

var _ Expr = StructLit{}

func (s StructLit) Subs(m map[Variable]Expr) Expr {
	return s
}

func (s StructLit) Eval() Expr {
	return s
}

func (s StructLit) Typing(ds []Decl, gamma Env) Type {
	fs := fields(ds, s.t)
	if len(s.es) != len(fs) {
		tmp := ""
		if len(fs) > 0 {
			tmp = fs[0].String()
			for _, v := range fs[1:] {
				tmp = tmp + ", " + v.String()
			}
		}
		panic("Arity mismatch: found=" +
			strings.Join(strings.Split(fmt.Sprint(s.es), " "), ", ") +
			", expected=[" + tmp + "]")
	}
	for i := 0; i < len(s.es); i++ {
		t := s.es[i].Typing(ds, gamma)
		u := fs[i].t
		if !u.Impl(ds, t) {
			panic("Arg expr must impl field type: arg=" + t.String() + " field=" + u.String())
		}
	}
	return s.t
}

func (s StructLit) String() string {
	var sb strings.Builder
	sb.WriteString(s.t.String())
	sb.WriteString("{")
	sb.WriteString(strings.Trim(strings.Join(strings.Split(fmt.Sprint(s.es), " "), ", "), "[]"))
	sb.WriteString("}")
	return sb.String()
}

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
