default: test

# OASIS_START
# OASIS_STOP

# Precommit target
#  Check style of code.
PRECOMMIT_ARGS= \
	    --exclude myocamlbuild.ml \
	    --exclude setup.ml \
	    --exclude README.txt \
	    --exclude INSTALL.txt \
	    --exclude Makefile \
	    --exclude configure \
	    --exclude _tags

precommit:
	-@if command -v OCamlPrecommit > /dev/null; then \
	  OCamlPrecommit $(PRECOMMIT_ARGS); \
	else \
	  echo "Skipping precommit checks.";\
	fi

precommit-full:
	OCamlPrecommit --full $(PRECOMMIT_ARGS)

test: precommit

.PHONY: precommit

# Headache target
#  Fix license header of file.

headache:
	find ./ \
	  -name _darcs -prune -false \
	  -o -name .git -prune -false \
	  -o -name .svn -prune -false \
	  -o -name _build -prune -false \
	  -o -name dist -prune -false \
	  -o -name '*[^~]' -type f \
	  | xargs headache -h _header -c _headache.config

.PHONY: headache


# Deploy target
#  Deploy/release the software.

OASIS2DEBIAN_ARGS=--distribution wheezy

deploy:
	admin-gallu-deploy --verbose \
		--debian_pkg --debuild --distdebuild --debian_upload \
		--oasis2debian_args "$(OASIS2DEBIAN_ARGS)" \
		--forge_upload --forge_group ocaml-globalvars --forge_user gildor-admin
	admin-gallu-oasis-increment --use_vcs \
		--setup_run --setup_args '-setup-update dynamic'

.PHONY: deploy
