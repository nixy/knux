BINARY=bin/nixy

bin/nixy: src/module-core.sh src/process.sh src/module-extra.sh src/module-python.sh src/module-development.sh
	echo '#!/usr/bin/env bash' > bin/nixy
	echo >> bin/nixy
	cat src/module-core.sh >> bin/nixy
	echo >> bin/nixy
	cat src/module-extra.sh >> bin/nixy
	echo >> bin/nixy
	cat src/module-python.sh >> bin/nixy
	echo >> bin/nixy
	cat src/module-development.sh >> bin/nixy
	echo >> bin/nixy
	cat src/process.sh >> bin/nixy
	chmod +x bin/nixy

clean: 
	rm -f bin/nixy
