//$ go run oopsla20-91/fgg -v -eval=10 fg/examples/hello/fmtprintf.go
// Cf. go run oopsla20-91/fgg/fg/examples/hello

// N.B. FG (or at least this implementation) is intended to be white-space *insensitive*.
// (E.g., this program could be written all on one line.)
// So the ';' are mandatory -- cannot replace by newlines (as in actual Go).
// (Newlines and other whitespace may be freely added, though.)
package main;
import "fmt";
type World struct{};
func (x0 World) hello() World { return x0.hello() };
func main() {
	fmt.Printf("%#v", World{}.hello())
}
