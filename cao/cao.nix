{ postgresql
, postgresqlBuildExtension
, # other regular mkDerivation arguments
  fetchFromGitHub
,
}:
postgresqlBuildExtension (finalAttrs: {
  # inherit (finalAttrs) finalPackage;
  name = "cao";
  src = ./.;
  makeFlags = [ "USE_PGXS=1" ];
  meta = {
    platforms = postgresql.meta.platforms;
  };
})
