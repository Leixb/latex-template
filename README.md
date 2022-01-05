LaTeX flake template
====================

`LaTeX` template that I use as a starting point for all my documents. It is
structured in multiple files ordered numerically. To compile simply
run `latexmk`.

Flakes
------

There is no need to use `flakes`, this template can be used with any working
`LaTeX` installation, but `flakes` allow for build reproducibility and a
standardized environment across all collaborators. This means that all the
`LaTeX` dependencies, `pygmentize` and all other dependencies are managed with
`nix`, allowing to compile the document without working about managing the
dependencies in different environments.

This makes it very easy to integrate the document deployment with [github
actions](https://github.com/marketplace/actions/install-nix#usage-with-flakes),
any other CI or [creating containers](https://nix.dev/tutorials/building-and-running-docker-images)
to build the document. Using, binary caches with `cachix` can speed up the
compilation significantly by caching all LaTeX packages.

To build the current in the current directory run:

```
nix build
```

Or even compile the document without even cloning it before hand with:

```
nix build github:leixb/latex-template
```

To get a shell with all the dependencies available:

```
nix develop
```

Note that you can use [direnv](https://github.com/direnv/direnv)
to have a controlled development environment for the document integrated
with your shell.

(All this commands are using nix 2.4 with flake support)
