{
  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      llvm = pkgs.llvmPackages_latest;
      lib = nixpkgs.lib;
    in
    {
      packages = {
        default =
          self.packages.${system}.cao;
        cao = (pkgs.postgresql_18.withPackages
          (ps: [
            (ps.callPackage ./cao.nix { })
          ])
        );
      };
      devShell = pkgs.mkShell rec {
        nativeBuildInputs = [
          pkgs.cmake
          llvm.lldb

          pkgs.clang-tools
          llvm.clang

          pkgs.gtest
          pkgs.gnumake

          pkgs.libpq
          pkgs.libpq.pg_config

          (pkgs.postgresql_18.withPackages
            (ps: [
              (ps.callPackage ./cao.nix { })
            ])
          )
        ];

        buildInputs = [
          llvm.libcxx
        ];

        CPATH = builtins.concatStringsSep ":" [
          (lib.makeSearchPathOutput "dev" "include" [ llvm.libcxx ])
          (lib.makeSearchPath "resource-root/include" [ llvm.clang ])
          (lib.makeSearchPath "include/postgresql/server" [ pkgs.libpq.dev ])
        ];
        #
        # makeFlags = [
        #   "USE_PGXS=1"
        # ];

        shellHook = ''
          # Augment the dynamic linker path
          export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${CPATH}"
          export LIBCLANG_PATH="${pkgs.libclang.lib}/lib";
          export PGDATA=./pg_data 
        '';
      };
    }
  );
}
