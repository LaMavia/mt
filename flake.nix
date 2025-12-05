{
  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShell = pkgs.mkShell {
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
        ]);
      };
    }
  );
}
