EXE_NAME=out
LLVM_PROG=main

all: main

main:
	@llc ${LLVM_PROG}.ll
	@clang -c ${LLVM_PROG}.s
	@clang -c runtime.c
	@clang runtime.o ${LLVM_PROG}.o -o ${EXE_NAME}
	@echo "Executable available: ${EXE_NAME}"

clean:
	rm -f ${LLVM_PROG}.o ${LLVM_PROG}.s runtime.o
