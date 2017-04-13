BINDIR := bin
BINARY := knux
SRCDIR := src
SRCS := $(addprefix $(SRCDIR)/,core.sh profile.sh process.sh generation.sh)

all: $(BINDIR)/$(BINARY)

$(BINDIR)/$(BINARY): $(SRCS) | $(BINDIR)
	echo "#!/usr/bin/env bash" > $@
	echo >> $@
	for file in $^; do\
	  cat $$file >> $@;\
	  echo >> $@;\
	done
	echo 'profproc "$$@"' >> $@
	chmod +x $@

$(BINDIR):
	mkdir $(BINDIR)

.PHONY: clean
clean: 
	-rm -rf $(BINDIR)
