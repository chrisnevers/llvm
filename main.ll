;   variables with % are local
;   variables with @ are global
;   locals represent register assignments

;   %result = mul i32 %x, 8
;       multiply by 8

;   registers are unlimited

;   alloca - allocates memory in the stack frame
;   it returns a pointer to the allocated memory
;       %a = alloca i32, align 4
;   this memory is freed when function returns

;   store - stores value into value
;       store i32 10, i32* %a, align 4
;   this stores 10 : i32 into the local variable a : int32 ptr

;   load - takes ptr and returns content of the ptr
;       %2 = load i32, i32* %a, align 4
;   load a value of type i32 from mem address %a
;   and store it in variable %2


;   mathematical instructions
;       %4 = add nsw i32 %2, %3
;   nsw - "no unsigned wrap"

;   branch instruction
;   br i32 %ifcond, label %then, label %else
;   Conditional assignment based on what label was just executed
;   %iftmp = phi double [ 1.0, %then ], [ %multtmp, %else ]

; int main () {
;   return 42;
; }
; =>
; define i32 @main() {
;     ret i32 42
; }

; // printint function is in runtime
;
; int main () {
;   int a = 32;
;   int b = 16;
;   int tmp = a + b;
;   printint (tmp);
;   return tmp;
; }
; =>

; load and print int via runtime
; declare external void @printint(i32)

; define i32 @main() {
;     %1 = alloca i32, align 4
;     %a = alloca i32, align 4
;     %b = alloca i32, align 4
;     store i32 0, i32* %1
;     store i32 32, i32* %a, align 4
;     store i32 16, i32* %b, align 4
;     %2 = load i32, i32* %a, align 4
;     %3 = load i32, i32* %b, align 4
;     %4 = add nsw i32 %2, %3
;     call void @printint(i32 %4)
;     ret i32 %4
; }


; load and print string via runtime
declare external void @printstring(i8*)

@mystr = internal constant [12 x i8] c"Hello there!"

define void @main() {
    %str = getelementptr [12 x i8], [12 x i8]* @mystr, i32 0, i64 0
    call void @printstring (i8* %str) nounwind
    ret void
}


;   (defn add (a, b) (+ a b))
define double @add(double %a, double %b) {
entry:
    %addtmp = fadd double %a, %b
    ret double %addtmp
}
