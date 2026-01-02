{
  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      llvm = pkgs.llvmPackages_latest;
      lib = nixpkgs.lib;
      postgres = pkgs.postgresql_17;

      # postgresqlSrc = pkgs.fetchurl {
      #   url = "https://ftp.postgresql.org/pub/source/v${postgres.version}/postgresql-${postgres.version}.tar.bz2";
      #   sha256 = "sha256-zjxNhdGbASH+DT+O8fpgH3GYnob4pm99w61UbdVWT+w=";
      # };
      #
      # pwd = builtins.getEnv "PWD";
      # modifiedPostgresql = postgres.overrideAttrs (old: {
      #   src = postgresqlSrc;
      #
      #   postInstall = ''
      #     ${old.postInstall or ""}
      #     # Copy over the extension files
      #     mkdir -p $out/share/postgresql/extension
      #     mkdir -p $lib/lib
      #     ln -s ${pwd}/myExtension.so $lib/lib
      #     ln -s ${pwd}/myExtension.control $out/share/postgresql/extension
      #     ln -s ${pwd}/myExtension--0.1.0.sql $out/share/postgresql/extension
      #   '';
      # });
    in
    {
      devShell = pkgs.mkShell rec {
        nativeBuildInputs = [
          pkgs.cmake
          llvm.lldb

          pkgs.clang-tools
          llvm.clang

          pkgs.gtest
          pkgs.gnumake
          pkgs.bear

          postgres
          pkgs.libpq
          pkgs.libpq.pg_config
        ];

        buildInputs = (with pkgs; [
          typst
          icu
          (rWrapper.override
            { packages = with rPackages; [ TreeDist languageserver ggtree treeio ]; })
        ]) ++ (with pkgs; [
          (python312.withPackages (ps: with ps; [
            jupyterlab
            jupyter
            graphviz
            matplotlib
            altair
            pandas
          ]))
        ]) ++ ([
          llvm.libcxx
        ]);

        CPATH = builtins.concatStringsSep ":" [
          (lib.makeSearchPathOutput "dev" "include" [ llvm.libcxx ])
          (lib.makeSearchPath "resource-root/include" [ llvm.clang ])
        ];

        shellHook = ''
          export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${CPATH}"
          export LIBCLANG_PATH="${pkgs.libclang.lib}/lib";
        '';

      };
    }
  );
}
