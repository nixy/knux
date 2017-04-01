BINDIR := bin
BINARY := knux
OBJDIR := obj
OBJS := $(addprefix $(OBJDIR)/,core.sh profile.sh process.sh generation.sh)

$(OBJDIR)/%.sh: src/%/*
	if [ -s $@ ]; then\
		rm $@;\
	fi
	echo "module=\"$$module $%"
	for file in $^; do\
		cat $$file >> $@;\
		echo >> $@;\
	done

all: $(BINDIR)/$(BINARY)

$(BINDIR)/$(BINARY): $(OBJS) | $(BINDIR)
	echo "#!/usr/bin/env bash" > $@
	echo >> $@
	for file in $^; do\
	  cat $$file >> $@;\
	  echo >> $@;\
	done
	echo 'process "$$@"' >> $@
	chmod +x $@

$(BINDIR):
	mkdir $(BINDIR)

$(OBJS): | $(OBJDIR)

$(OBJDIR):
	mkdir $(OBJDIR)

.PHONY: clean
clean: 
	-rm -rf $(OBJDIR)
	-rm -rf $(BINDIR)

# interpreter=/usr/bin/env bash

# bin/nixy: obj/*
# 	echo $(interpreter) > $@
# 	for file in $^; do cat $$file >> $@; echo >> $@; echo
#

# bin/nixy: obj/%.sh
# 	echo Some shit

# obj/%.sh: src/%
# 	echo Some shit

# src/%.sh: src/$%/*
# 	echo $^

# obj/core.sh: src/core/*
# 	if [ -s $@ ]; then\
# 		rm $@;\
# 	fi
# 	for file in $^; do\
# 		cat $$file >> $@;\
# 		echo >> $@;\
# 	done

# BINARY=bin/nixy
# bin/nixy: src/module-core.sh src/process.sh src/module-extra.sh src/module-python.sh src/module-development.sh
# 	echo '#!/usr/bin/env bash' > bin/nixy
# 	echo >> bin/nixy
# 	cat src/module-core.sh >> bin/nixy
# 	echo >> bin/nixy
# 	cat src/module-extra.sh >> bin/nixy
# 	echo >> bin/nixy
# 	cat src/module-python.sh >> bin/nixy
# 	echo >> bin/nixy
# 	cat src/module-development.sh >> bin/nixy
# 	echo >> bin/nixy
# 	cat src/process.sh >> bin/nixy
# 	chmod +x bin/nixy
