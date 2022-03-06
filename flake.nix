{
  description = "Build LaTeX document with minted";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    {
      templates.document = {
        path = ./.;
        description = "LaTeX document with minted support";
      };
      defaultTemplate = self.templates.document;
    } // flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        latex-packages = with pkgs; [
          (texlive.combine {
            inherit (texlive)
              scheme-medium
              framed
              titlesec
              cleveref
              multirow
              wrapfig
              tabu
              threeparttable
              threeparttablex
              makecell
              environ
              biblatex
              biber
              fvextra
              upquote
              catchfile
              xstring
              csquotes
              minted
              dejavu
              comment
              footmisc
              xltabular
              ltablex
              ;
          })
          which
          python39Packages.pygments
        ];

        dev-packages = with pkgs; [
          texlab
          zathura
          wmctrl
        ];
      in
      rec {
        devShell = pkgs.mkShell {
          buildInputs = [ latex-packages dev-packages ];
        };

        lib.latexmk = import ./build-document.nix;
        
        packages = flake-utils.lib.flattenTree {
          document = lib.latexmk {
            inherit pkgs;
            texlive = latex-packages;
            shellEscape = true;
            minted = true;
            SOURCE_DATE_EPOCH = toString self.lastModified;
          };
        };

        defaultPackage = packages.document;
      }
    );
}
