VERSION = 3.05

PREFIX = $(TRAPPATH)
BINDIR = $(PREFIX)/bin

OBJS  = ANNOTATE.o
OBJS += annotate_sequence.o
OBJS += matrix_properties.o
OBJS += read_matrix.o
OBJS += region_read.o
OBJS += score_calc.o

.PHONY: all
all: ANNOTATE

.PHONY: clean
clean:
	rm -f $(OBJS) ANNOTATE

.PHONY: install
install: all
	mkdir -p $(DESTDIR)$(BINDIR)
	install -m 755 ANNOTATE $(DESTDIR)$(BINDIR)/ANNOTATE_v$(VERSION)

ANNOTATE: $(OBJS)
	g++ -o $@ $(OBJS)

%.o: %.cpp
	g++ -O3 -Wall -c -o $@ $<
