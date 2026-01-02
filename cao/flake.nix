{
  inputs = {
    utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      llvm = pkgs.llvmPackages_latest;
      lib = nixpkgs.lib;

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
        ];

        buildInputs = [
          llvm.libcxx
        ];

        CPATH = builtins.concatStringsSep ":" [
          (lib.makeSearchPathOutput "dev" "include" [ llvm.libcxx ])
          (lib.makeSearchPath "resource-root/include" [ llvm.clang ])
        ];

        shellHook = ''
          # Augment the dynamic linker path
          export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${CPATH}"
          export LIBCLANG_PATH="${pkgs.libclang.lib}/lib";
        '';
      };
    }
  );
}
