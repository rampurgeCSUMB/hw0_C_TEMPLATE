all: a.out

a.out:
	g++ -std=c++11 main.cc

.PHONY: run
run: a.out
	@./a.out

.PHONY: clean
clean:
	rm a.out
