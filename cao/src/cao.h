#ifndef CAO_H
#define CAO_H

#if PG_VERSION_NUM >= 90100
#define CAO_GUC_HOOK_VALUES NULL, NULL, NULL
#else
#define CAO_GUC_HOOK_VALUES NULL, NULL
#endif

void _PG_init(void);
void _PG_fini(void);

#endif /* CAO_H */
