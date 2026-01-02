{ postgresql
, postgresqlBuildExtension
, # other regular mkDerivation arguments
  fetchFromGitHub
,
}:
postgresqlBuildExtension (finalAttrs: {
  pname = "cao";
  src = ./.;
  meta = {
    platforms = postgresql.meta.platforms;
  };
})
