ARMAKE=$(abspath .build/bin/armake)
ARMAKESRC=https://github.com/TheMysteriousVincent/armake.git
TAG=$(shell git describe --tag | sed "s/-.*-/-/")
PACKAGES_SERVER=artillery common composition database headless headquarter intercept main mission spawn worlds
MISSIONS=Operation_Kerberos.Altis

all: removeAll \
	$(MISSIONS) \
	$(PACKAGES_SERVER) \
	remove

deps:
	sudo apt-get install -y git bison flex libssl-dev python3

build_armake: prepare
	@if [ ! -d .build/armake ]; then git clone $(ARMAKESRC) .build/armake ; \
		cd .build/armake \
		&& make \
		&& cd ../../ \
		&& cp -f .build/armake/bin/armake .build/bin/ ; \
	fi

prepare:
	mkdir -p .build/missions/
	mkdir -p .build/bin/
	mkdir -p .build/keys/
	mkdir -p .build/addons/

createKey: build_armake
ifndef PRVKEYFILE
	cd .build/keys/ && $(ARMAKE) keygen -f kgg_$(TAG)
	$(eval KEY := kgg_$(TAG))
	$(eval PRVKEYFILE := .build/keys/$(KEY).biprivatekey)
endif

test: prepare
	git clone https://github.com/TheMysteriousVincent/sqf.git .build/sqf
	python3 .build/sqf/sqflint.py -d addons/
	python3 .build/sqf/sqflint.py -d missions/
	python3 tools/validator_cfg.py

$(PACKAGES_SERVER): build_armake createKey
	$(ARMAKE) build -p --force -k $(PRVKEYFILE) -e prefix=x\\dorb\\addons\\$@ addons/$@ .build/addons/dorb_$@.pbo

$(MISSIONS): build_armake
	$(ARMAKE) build -p --force missions/$@ .build/missions/$@.pbo

remove:
	rm -Rf .build/armake
	rm -Rf .build/bin
	rm -Rf .build/sqf

removeAll:
	rm -Rf .build/

