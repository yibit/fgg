//$ go run oopsla20-91/fgg -v -eval=3 fg/examples/prev/whoopsie/rose.go

package main;

type RoseByAnotherName interface {};

type I1 interface { Equal(that Any) Bool };
type I2 interface { Equal(that RoseByAnotherName) Bool };

type T struct {};
func (t T) Equal(foo Any) Bool { return Bool{} };
type Any interface {};
type ToAny struct { any Any };
type Bool struct {};  // Just for the purposes of this example

func main() {
	_ = ToAny{T{}}.any.(I1).(I2)
}
