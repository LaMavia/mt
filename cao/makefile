EXTENSION    = cao
EXTVERSION   = $(shell grep default_version $(EXTENSION).control | \
               sed -e "s/default_version[[:space:]]*=[[:space:]]*'\([^']*\)'/\1/")

PG_CONFIG    = pg_config


MODULE_big = cao
OBJS = src/cao_main.o

# make sure
all: all-lib

PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
