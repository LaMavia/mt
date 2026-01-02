{ postgresql
, postgresqlBuildExtension
,
}:
postgresqlBuildExtension (finalAttrs: {
  name = "cao";
  src = ./.;
  makeFlags = [ "USE_PGXS=1" ];
  meta = {
    platforms = postgresql.meta.platforms;
  };
})
