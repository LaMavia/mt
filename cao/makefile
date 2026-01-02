EXTENSION    = cao
EXTVERSION   = $(shell grep default_version $(EXTENSION).control | \
               sed -e "s/default_version[[:space:]]*=[[:space:]]*'\([^']*\)'/\1/")

DOCS         = $(wildcard doc/*.md)
TESTS        = $(wildcard test/sql/*.sql)
REGRESS      = $(patsubst test/sql/%.sql,%,$(TESTS))
REGRESS_OPTS = --inputdir=test
PG_CONFIG    = pg_config

# EXTRA_CLEAN = src/cao_probes.h

MODULE_big = cao
OBJS = src/cao_main.o
# OBJS = src/cao_main.o src/cao_util.o src/cao_trees.o \
# 	src/cao_recalc.o src/cao.o

# make sure
all: all-lib

# check for DTrace support
ifeq (,$(findstring --enable-dtrace,$(shell $(PG_CONFIG) --configure)))
enable_dtrace = no
else
enable_dtrace = yes
endif

ifeq ($(enable_dtrace), yes)
# OBJS += src/cao_probes.o
endif

# Check if nix exists, and set PG_CONFIG accordingly
# IS_NIX := $(shell which nix > /dev/null 2>&1 && echo yes || echo no)
# ifeq ($(IS_NIX),yes)
#    PG_CONFIG = ./pg_config_nix.sh
# else
#    PG_CONFIG = pg_config
# endif
# PGXS := $(shell $(PG_CONFIG) --pgxs)
# include $(PGXS)

# src/cao.o: src/cao_probes.h

# src/cao_probes.o: src/cao_probes.d
# 	$(DTRACE) -C -G -s $< -o $@
#
# ifeq ($(enable_dtrace), no)
# src/cao_probes.h: src/Gen_dummy_probes.sed
# endif
#
# src/cao_probes.h: src/cao_probes.d
# ifeq ($(enable_dtrace), yes)
# 	$(DTRACE) -C -h -s $< -o $@.tmp
# 	sed -e 's/cao_/TRACE_cao_/g' $@.tmp >$@
# 	rm $@.tmp
# else
# 	sed -f src/Gen_dummy_probes.sed $< >$@
# endif

# PGXS := $(shell $(PG_CONFIG) --pgxs)
# include $(PGXS)
