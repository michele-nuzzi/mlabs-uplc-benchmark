{
  perSystem = { pkgs, self', config, ... }:
    let
      liqwid-libs = config.libUtils.applyPatches {
        name = "liqwid-libs-patched";
        src = pkgs.fetchFromGitHub {
          owner = "Liqwid-Labs";
          repo = "liqwid-libs";
          rev = "e45647e49a106d64799193491af4e52553917ead";
          hash = "sha256-ioUyXgpBGLYjLtMIFRFFtV+h8QoRIi3TaYsb2GgWrg4=";
        };
        patches = [ ./liqwid-libs-exports.patch ];
      };

      # TODO: Update from PR to master
      # https://github.com/mlabs-haskell/ply/pull/50
      ply = pkgs.fetchFromGitHub {
        owner = "mlabs-haskell";
        repo = "ply";
        rev = "0b58813ad022ea8fd35aa309b935ad5b474a7e1d";
        hash = "sha256-om9EEGrw09gm0i+i9GYp0KYWQMXAd6ZvAZPzW6cGSLw=";
      };

      uplc-benchmark-tests =
        config.libHaskell.mkPackage (config.libPlutarch.mkPackage {
          name = "uplc-benchmark-tests";
          src = ./.;
          ghcVersion = "ghc928";
          externalDependencies = [
            "${liqwid-libs}/liqwid-plutarch-extra"
            "${liqwid-libs}/liqwid-script-export"
            "${liqwid-libs}/plutarch-benchmark"
            "${liqwid-libs}/plutarch-context-builder"
            "${liqwid-libs}/plutarch-quickcheck"
            "${liqwid-libs}/plutarch-unit"
            "${ply}/ply-core"
            "${ply}/ply-plutarch"
            self'.packages.uplc-benchmark-types-plutus
          ];
        });
    in
    {
      checks.uplc-benchmark = uplc-benchmark-tests.checks."uplc-benchmark:test:uplc-benchmark-tests".overrideAttrs (prev: {
        env = (prev.env or { }) // {
          UPLC_BENCHMARK_BIN_PLUTARCH = self'.packages.plutarch-implementation-compiled.outPath;
        };
      });

      devShells.tests = pkgs.mkShell {
        shellHook = config.pre-commit.installationScript;
        inputsFrom = [
          uplc-benchmark-tests.devShell
        ];
      };
    };
}
