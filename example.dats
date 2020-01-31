/*
 * Example DATS file
 *
 * This code is meant to provide an example of a bunch of different ATS syntax
 * to help with testing changes to the syntax/ats.vim file.
 *
 * You can compile and run this file with:
 *
 *   % patscc -DATS_MEMALLOC_LIBC -o example example.dats -lrt
 *   % ./example
 *
 */

/*
 * Examples of highlighting various file inclusion methods.
 */
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

/*
 * Examples of highlighting definition of names that have special
 * meaning to the ATS compiler.
 */
#define ATS_PACKNAME "Example.kitchen_sink"
#define ATS_EXTERN_PREFIX "kitchen_sink_"
#define ATS_STATIC_PREFIX "_kitchen_sink_"

%{^
#include <alloca.h>
#include <errno.h>
%}

#if 0 #then
/*
 * ATS supports a special environment variable, PATSHOMELOCS, which can be
 * used at the beginning of a path to load. It should be called out via
 * highlighting.
 */
#include "$PATSHOMELOCS/atscntrb-hx-globals/HATS/gcount.hats"
#endif

#define PRELUDE_targetloc "prelude/SATS"

// You can use #staload or staload equivalently
#staload UNSAFE = "{$PRELUDE}/unsafe.sats"
staload UNSAFE = "{$PRELUDE}/unsafe.sats"

// You can use already declared names
staload UN = $UNSAFE
staload $UN

// You can use numbers, _, ', and $ in names.
staload NOT0SAFE = $UNSAFE
staload NOT_SAFE = $UNSAFE
staload NOT'SAFE = $UNSAFE
staload NOT$SAFE = $UNSAFE

staload $NOT0SAFE
staload $NOT_SAFE
staload $NOT'SAFE
staload $NOT$SAFE

/*
 * Example of highlighting preprocessor syntax.
 */

#ifdef FOO
  #print "FOO is defined; undefining!\n"
  #undef FOO
#elifdef BAR
  #prerr "BAR should not be defined!\n"
#elifndef BAZ
  #define BAZ 3
#else
  #assert (BAZ >= 1 && BAZ <= 5)
#endif

implement main0 () = ()

/*
 * Examples of highlighting constants.
 */

// Highlighting octal. The leading zero should be colored differently.
val i: int 8 = 010
val i: lint 8 = 010l
val i: llint 8 = 010ll
val i: uint 8 = 010u
val i: ulint 8 = 010ul
val i: ullint 8 = 010ull

// Highlighting decimal.
val i: int 10 = 10
val i: lint 10 = 10l
val i: llint 10 = 10ll
val i: uint 10 = 10u
val i: ulint 10 = 10ul
val i: ullint 10 = 10ull

// Highlighting hexadecimal.
val i: int 16 = 0x10
val i: lint 16 = 0x10l
val i: llint 16 = 0x10ll
val i: uint 16 = 0x10u
val i: ulint 16 = 0x10ul
val i: ullint 16 = 0x10ull

// Highlighting floats.
val f: float = 5.f
val f: float = 5.0f
val f: float = .5f
val f: float = 0.5f
val f: float = 5e-1f
val f: float = 5e+1f
val f: float = 5e10f
val f: float = 5.e1f

// Highlighting hex floats
val xf: float = 0x5p10f
val xf: float = 0x5p-10f
val xf: float = 0x5p+10f
val xf: float = 0x50.00p-1f

// Highlighting doubles.
val d: double = 2.
val d: double = 2.0
val d: double = .2
val d: double = 0.2

// Highlighting hex doubles
val xd: double = 0x2p10
val xd: double = 0x2p-10
val xd: double = 0x2p+10
val xd: double = 0x20.00p-1

// Highlighting long doubles.
val ld: ldouble = 2.l
val ld: ldouble = 2.0l
val ld: ldouble = .2l
val ld: ldouble = 0.2l

// Highlighting hex long doubles.
val xld: ldouble = 0x2p10l
val xld: ldouble = 0x2p-10l
val xld: ldouble = 0x2p+10l
val xld: ldouble = 0x20.00p-1l

// It's okay for the suffix, exponent or hex "X" to be upper case.
val i: ullint 8 = 010ULL
val i: ullint 10 = 10ULL
val i: ullint 16 = 0X10ULL
val f: float = 5.F
val f: float = 5E10F
val d: ldouble = 2E10L
val ld: ldouble = 2.E10l
val xf: float = 0x5P10F
val xd: double = 0x2P10
val xld: ldouble = 0x2P10L

// Or to place the "U" at the end.
val i: ullint 8 = 010LLU
val i: ullint 10 = 10LLU
val i: ullint 16 = 0x10LLU

// Highlighting strings.
var str: string 2 = "\1234" // '4' is visually distinct from '\123'
val str: string 11 = "foo\nbar\tbaz" // '\n' and '\t' are visually distinct
val str: string 4 = "foo\\" // Literal backslash at end
val str: string 5 = "foo\\\"" // Literal backslash and double quote at end

// Highlighting normal characters.
val c = 'a'

// Highlighting special sequences.
val c: char '\x07' = '\a'
val c: char '\x08' = '\b'
val c: char '\x0C' = '\f'
val c: char '\x0A' = '\n'
val c: char '\x0D' = '\r'
val c: char '\x09' = '\t'
val c: char '\x0B' = '\v'

// Highlighting octal syntax.
val c: char 'S' = '\123'
val c: char 0 = '\0'

// Highlighting octal syntax
val c: char '~' = '\x7E'
val c: char '~' = '\X7E'

// Highlighting character literals (optional escaping).
val c: char ')' = '\)'
val c: char ']' = '\]'
val c: char '}' = '\}'
val c: char '"' = '\"'
val c: char '?' = '\?'

// Highlighting character literals (necessary escaping).
val c: char '\x27' = '\''
val c: char '\x28' = '\('
val c: char '\x5B' = '\['
val c: char '\x5C' = '\\'
val c: char '\x7B' = '\{'

// Boxed data whose contents are characters.
val box_tup = '( 'a', 'b' )
val box_rec = '{ a= 'a', b= 'b' }

// Flat data
var flat_tup = @( '@' )
var flat_arr = @[char '@']( '@' )
var flat_rec = @{ at= '@' }

// Accessing fields. 
val _ = flat_tup.0 // '.0' should not be highlighted like a float.
val _ = flat_arr[0] // [] should be visually distinct from the identifier and 0
val _ = flat_rec.at // '.' should be separate from the identifiers

// "null" should be concealed with ∅, and highlighted as a constant when shown.
val the_null_ptr: ptr null = $UN.cast{ptr null}0

/*
 * Examples of highlighting identifiers.
 */

val a = 5
val A = 5
val _a = 5
val a_b = 5
val a$b = 5
val abcd = 5
val a123 = 5
val aA_12$ = 5
val a'b = 5
val a'b' = 5
val a'b'c = 5
val a' = 5
val a'' = 5
val a''' = 5
val a'$'a' = 5
val a'_'a' = 5

// "abc" should be highlighted as an identifier after the addr@/view@ keywords.
var abc = 5
val a = addr@abc
prval v = view@abc

/*
 * Examples of higlighting structured control flow.
 */

// if/then/else
fun a {i: int} (i: int i): int (max(i + 10, 0)) =
  if i < ~10 then
    0
  else i + 10

// ifcase
fun b {i: int} (i: int i): int (max(i + 10, 0)) =
  ifcase
  | i < ~10 => 0
  | _ => i + 10

// case
fun c {n: int} (lst: !list_vt (int, n)): void =
  case lst of
  | list_vt_nil() => ()
  | list_vt_cons(_, rest) => c(rest)

// while loop
fun fib1 {n: nat} (n: int n): int = let
  var prev: int = 0
  var curr: int = 1
  var i: int = 0
in
  while (i < n) {
    val next = prev + curr
    val () = prev := curr
    val () = curr := next
    val () = i := i + 1
  };

  curr
end

// for loop
fun fib2 {n: nat} (n: int n): int = let
  var prev: int = 0
  var curr: int = 1
  var i: int
in
  for (i := 0; i < n; i := i + 1) {
    val next = prev + curr
    val () = prev := curr
    val () = curr := next
  };

  curr
end

// for* loop
fun fib3 {n: nat} (n: int n): int = let
  var prev: int = 0
  var curr: int = 1
  var i: int
in
  for* {i: nat | i <= n} .<n-i>. (
    i: int i
  ) => (i := 0; i < n; i := i + 1) {
    val next = prev + curr
    val () = prev := curr
    val () = curr := next
  };

  curr
end

macdef check_fib (i, o) = begin
  assertloc(fib1(,(i)) = ,(o));
  assertloc(fib2(,(i)) = ,(o));
  assertloc(fib3(,(i)) = ,(o));
end

val () = check_fib(0, 1)
val () = check_fib(1, 1)
val () = check_fib(2, 2)
val () = check_fib(3, 3)
val () = check_fib(4, 5)
val () = check_fib(5, 8)
val () = check_fib(6, 13)

// while* loop using the $break and $continue keywords
fun bsearch {n: nat} (arr: &(@[int][n]), len: int n, v: int): Option (int) = let
  var bounds: (Nat, Int) = (0, len - 1)
  var idx: Option (Int) = None
in
  while* {l,u: int | 0 <= l; l <= u + 1; u + 1 <= n} .<u+1-l>. (
    bounds: (int l, int u)
  ) => 
    (bounds.0 <= bounds.1) {
    val+(lower, upper) = bounds
    val middle = lower + half(upper - lower)
    val sgn = compare(v, arr[middle])
    val () =
      if sgn = 0 then
        (idx := Some(middle); $break)

    typedef shrink (l: int, u: int) =
      [
        j,k: int
      | j <= k + 1;
        (l < j && u == k) || (l == j && k < u)
      ] @(int j, int k)

    val next =
      (if sgn >= 0 then
        (middle + 1, upper)
      else (lower, middle - 1)): shrink (l, u)

    val () = (bounds := next; $continue)
  };

  idx
end

#define LEN 11
var arr = @[int][LEN](~10,~5,0,2,6,9,15,20,31,80,900)

fun bsearch_test(arr: &(@[int][LEN]), v: int, exp: Option (int)): void = let
  implement option_equal$eqfn<int>(a, b) = g0int_eq(a, b)

  val res = bsearch(arr, LEN, v)
in
  assertloc(option_equal<int>(res, exp))
end

val () = bsearch_test(arr, ~10, Some(0))
val () = bsearch_test(arr, ~5, Some(1))
val () = bsearch_test(arr, 0, Some(2))
val () = bsearch_test(arr, 2, Some(3))
val () = bsearch_test(arr, 6, Some(4))
val () = bsearch_test(arr, 9, Some(5))
val () = bsearch_test(arr, 15, Some(6))
val () = bsearch_test(arr, 20, Some(7))
val () = bsearch_test(arr, 31, Some(8))
val () = bsearch_test(arr, 80, Some(9))
val () = bsearch_test(arr, 900, Some(10))
val () = bsearch_test(arr, ~11, None)
val () = bsearch_test(arr, ~9, None)
val () = bsearch_test(arr, 19, None)
val () = bsearch_test(arr, 21, None)

/*
 * Examples of highlighting macro definitions and syntax.
 */

macdef times2 (x) = let val y = ,(x) in (y + y) end
macdef times4 (x) = let val y = ,(x) in times2 (y + y) end

val () = println! (times4 (4))

macrodef rec fact (x) =
  if x = 0 then `(1) else `(%(x) * ,(fact (x - 1)))

val () = assertloc (,(fact (5)) = 120)

macrodef rec power(x, n) =
  if n = 0 then `(1) else `(,(x) * ,(power (x, n - 1)))

fun pow3 (x: Int): Int = ,(power (`(x), 3))
fun pow4 (x: Int): Int = ,(power (`(x), 4))

val () = assertloc (pow3(5) = 125)
val () = assertloc (pow4(4) = 256)

/*
 * Examples of highlighting various constructors.
 */

datatype A (t: t@ype) =
  | A_some (t) of (t)
  | A_none (t) of ()

dataview V (v: view+, bool) =
  | V_some (v, true) of (v)
  | V_none (v, false) of ()

dataviewtype VT (t: t@ype+, bool) =
  | VT_some (t, true) of (t)
  | VT_none (t, false) of ()

datasort mynat =
  | Succ of (mynat)
  | Zero of ()

dataprop EVEN (mynat) =
  | EVENbas (Zero ()) of ()
  | {n: mynat}
    EVENind (Succ (Succ (n))) of (EVEN (n))


/*
 * Examples of highlighting type definitions.
 */

sortdef four = {a: int | a == 4}

stadef five = 5
sexpdef six = 6

typedef returns5 = () -<> int five
typedef returns6 = () -<> int six

propdef mul5 = [m,p: int] MUL (m, five, p)

viewtypedef VTfive (b: bool) = VT (int five, b)
vtypedef VTstrfive (b: bool) = VT (string (five), b)

viewdef VfiveatL (l: addr, b: bool) = V (int five @ l, b)

tkindef kindexmpl = "atstype_uint8";


/*
 * Examples of highlighting abstract type definitions.
 */

// abstract boxed type
abstbox absptr
abstype absptr

// abstract flat type
abstflt absint
abstflat absint
abst@ype absint
abst0ype absint

// linear abstract boxed type
absvtype absintptr
absvtbox absintptr
absviewtype absintptr

// linear abstract flat type
absvtflt absvtat
absvtflat absvtat
absvt@ype absvtat
absvt0ype absvtat
absviewt@ype absvtat
absviewt0ype absvtat

// abstract view
absview myview

// abstract proposition
absprop MYPROP

local
  absimpl absptr = ptr
in
  var a = 5
  val b: absptr = addr@a
end

local
  absreimpl absptr
in
  var a = 5
  val b: absptr = addr@a
end

local
  assume absintptr = [l: addr] (int @ l | ptr l)
in
  var a = 5
  val b: absintptr = (view@a | addr@a)
end

local
  reassume absintptr
in
  var a = 5
  val b: absintptr = (view@a | addr@a)
end

/*
 * Examples of highlighting withtype and friends.
 */

fun id1 (n) = n
  withtype {n: nat} int (n) -> [i: nat | i == n] int (i)

val vtn = VT_none ()
  withvtype VT (string, false)

val vtn = VT_some ("foo")
  withviewtype VT (string, true)

prval mul = mul_make {5,2} ()
  withprop MUL (5, 2, 10)

prval vn = V_none ()
  withview [l: addr] V (int @ l, false)

/*
 * Examples of highlighting exception-related keywords.
 */

exception Error of ()

fun throws1 (): void =
  $raise (Error())

fun throws2 (): void =
  raise (Error())

fun catches1 (): void =
  try throws1() with ~Error() => throws2()

/*
 * Examples of highlighting debugging-related keywords.
 */

val (_) = $showtype (5) // Print the type of 5 at compile time.

val () = println! ("the source file is ", $myfilename)
val () = println! ("this println! is located at ", $mylocation)

/*
 * Examples of highlighting functions with effects.
 */

fun pure1 .<>. ():<fun0> void = ()

fun pure2 .<>. ():<fun,0> void = ()

fun pure3 .<>. ():<fun,!nil> void = ()

fun pure4 .<>. ():<fun,1,~all> void = ()

fun effectful1 ():<fun1> void = ()

fun effectful2 ():<fun,1> void = ()

fun nonterm1 ():<fun0,!ntm> void =
  nonterm1 ()

fun exceptional1 .<>. (a: int):<fun0,!exn> void =
  $raise Error ()

fun writing1 .<>. ():<fun0,!wrt> void =
  ()

fun referrer1 .<>. ():<fun0,!ref> void =
  ()

typedef exnfun (t1: t@ype, t2: t@ype) = t1 -<fun0,!exn> t2
val f: exnfun (int, void) = exceptional1

typedef exnclo (t1: t@ype, t2: t@ype) = t1 -<clo0,!exn> t2
val f: exnclo (int, void) =
  lam@ (i: int) =<clo,0,!exn> if i > 5 then $raise Error () else ()

typedef exncloref (t1: t@ype, t2: t@ype) = t1 -<cloref0,!exn> t2
val f: exncloref (int, void) =
  lam (i: int) =<cloref,0,!exn> if i > 5 then $raise Error () else ()

vtypedef exncloptr (t1: t@ype, t2: t@ype) = t1 -<cloptr0,!exn> t2
val f: exncloptr (int, void) =
  lam (i: int) =<cloptr,0,!exn> if i > 5 then $raise Error () else ()

typedef fefun (t1: t@ype, t2: t@ype, fe: eff) = t1 -<fun,fe> t2
typedef nilfun = fefun (int, int, effnil)
typedef allfun = fefun (int, int, effall)
typedef ntmfun = fefun (int, int, effntm)
typedef exnfun = fefun (int, int, effexn)
typedef reffun = fefun (int, int, effref)
typedef wrtfun = fefun (int, int, effwrt)

/*
 * Examples of highlighting effect-masking keywords.
 */

fun masked_exn .<>. ():<fun0> void =
  $effmask_exn (exceptional1 (1))

fun masked_wrt .<>. ():<fun0> void =
  $effmask_wrt (writing1 ())

fun masked_ref .<>. ():<fun0> void =
  $effmask_ref (referrer1 ())

fun masked_all .<>. ():<fun0> void =
  $effmask_all (effectful1 ())

fun masked_ntm .<>. ():<fun0> void =
  $effmask {!ntm} (nonterm1 ())

/*
 * Examples of highlighting C blocks.
 */

%{^
/*
 * The "%{^" syntax introduces a C block that will be placed at the top of
 * the generated C file, and should be highlighted as Special.
 *
 * Code inside here is highlighted using C syntax highlighting.
 */
#include <stdlib.h>

typedef struct plbc {
	int plbc_i;
	void (*plbc_f)(int, char *, void *);
} PercentLBracketCaret;
%}

%{$
/*
 * The "%{$" syntax introduces a C block that will be placed at the end of
 * the generated C file, and should be highlighted as Special.
 *
 * Code inside here is highlighted using C syntax highlighting.
 */
#include <stdlib.h>

typedef struct plbd {
	int plbd_i;
	void (*plbd_f)(int, char *, void *);
} PercentLBracketDollar;
%}

%{#
/*
 * The "%{#" syntax introduces a C block (usually in a *.sats file) that will
 * be placed inside the generated C file of *.dats files that staload it.
 */
#include <stdlib.h>

typedef struct plbh {
	int plbh_i;
	void (*plbh_f)(int, char *, void *);
} PercentLBracketHash;
%}

%{
/*
 * The "%{" syntax introduces a C block that will be placed in an unspecified
 * location somewhere within the generated C file, and should be highlighted
 * as special.
 *
 * Code inside here is highlighted using C syntax highlighting.
 */
#include <stdlib.h>

typedef struct plb {
	int plb_i;
	void (*plb_f)(int, char *, void *);
} PercentLBracket;
%}


/*
 * Examples of working with external types.
 */

typedef PercentLBracket = $extype "PercentLBracket"
typedef PercentLBracketCaret = $extype_struct "PercentLBracketCaret" of {
  plb_i= int,
  plb_f= (int, string, ptr) -> void
}


/*
 * Examples of working with external values.
 */

extvar "errno" = 0
val errno = $extval(int, "errno")
val _ = $extfcall(int, "printf", "first printf example: %.3s, %0*d\n", "aaab", 4, 5)

extern fun printf {ts: types} (string, ts): int = "mac#"
val _ = printf("second printf example: %.3s, %0*d\n", $vararg("aaab", 4, 5))


/*
 * Here are some examples of comments.
 */

/*
 * Comments can contain the text TODO, FIXME, and XXX, which should
 * be highlighted (probably in a yellowish color).
 *
 * If spellchecking is turned on in Vim (:set spell), then words like
 * foobarbaz should be be highlighted (probably in a reddish color).
 */

// This is a double-slash comment, which ends at the end of the line.

val a = 5 // This is a double-slash comment after a statement.
val a = 5 /* This is a slash-star comment after a statement. */
val a = 5 (* This is a paren-star comment after a statement. *)

/*
 * This is a multi-line slash-star comment.
 */
val a = 5

(*
 * This is a multi-line paren-star comment.
 *)
val a = 5

(*

Paren-star comments can be nested:

(* This is the definition for `a'. *)
val a = 5;

This is still a comment.

*)
val a = 5

////

Above is an end of file comment. Everything in the rest of this file should
be highlighted as a commment. For example:

fun foo (): int = 5
