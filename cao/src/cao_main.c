#include "cao.h"
#include "postgres.h"

#include <limits.h>
#include <stdio.h>

#include "utils/elog.h"
#include "utils/guc.h"

PG_MODULE_MAGIC;

/* Module load */
void _PG_init(void) { elog(INFO, "Hello from CAO!"); }

/* Module unload */
void _PG_fini(void) {}
