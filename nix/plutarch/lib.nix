{ fetchFromGitHub
, mkHaskellPackage
, applyPatches
, fetchpatch
}:

let
  plutarchPackage = applyPatches {
    name = "plutarch-patched";
    src = fetchFromGitHub {
      owner = "Plutonomicon";
      repo = "plutarch-plutus";
      rev = "288d9140468ae98abe1c9a4c0bb1c19a82eb7cd6"; # branch: master
      hash = "sha256-aeaZMW5Y3r5GdSyrfrrKOuGahcL5MVkDUNggunbmtv0=";
    };

    patches = [
      # https://github.com/Plutonomicon/plutarch-plutus/pull/650
      (fetchpatch {
        url = "https://github.com/Plutonomicon/plutarch-plutus/commit/7256acb8db3230d2453460f0358582283c69da5f.patch";
        hash = "sha256-y/F1ZwLDC5E4vh8F+JTQStHJsQ1ZEe9LIZcwSGMSUek=";
      })
    ];
  };

  cardanoPackages = fetchFromGitHub {
    owner = "IntersectMBO";
    repo = "cardano-haskell-packages";
    rev = "e062328804c933d296e5956c989b326ea3c69eeb"; # branch: repo
    hash = "sha256-IH5nYTjx+CYAK4zQAkOs475X+AOhP/GPgwXm5LQHsEE=";
  };
in

args:
mkHaskellPackage (args // {
  externalRepositories = {
    "https://input-output-hk.github.io/cardano-haskell-packages" = cardanoPackages;
  } // (args.externalRepositories or { });

  externalDependencies = [
    "${plutarchPackage}"
    "${plutarchPackage}/plutarch-extra"
  ] ++ (args.externalDependencies or [ ]);
})
