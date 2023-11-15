{ system
  , compiler
  , flags
  , pkgs
  , hsPkgs
  , pkgconfPkgs
  , errorHandler
  , config
  , ... }:
  ({
    flags = { development = false; secp256k1-support = true; };
    package = {
      specVersion = "2.2";
      identifier = { name = "cardano-crypto-class"; version = "2.0.0.1"; };
      license = "Apache-2.0";
      copyright = "2019-2021 IOHK";
      maintainer = "operations@iohk.io";
      author = "IOHK";
      homepage = "";
      url = "";
      synopsis = "Type classes abstracting over cryptography primitives for Cardano";
      description = "Type classes abstracting over cryptography primitives for Cardano";
      buildType = "Simple";
      };
    components = {
      "library" = {
        depends = [
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."aeson" or (errorHandler.buildDepError "aeson"))
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."base16-bytestring" or (errorHandler.buildDepError "base16-bytestring"))
          (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
          (hsPkgs."cardano-binary" or (errorHandler.buildDepError "cardano-binary"))
          (hsPkgs."cardano-strict-containers" or (errorHandler.buildDepError "cardano-strict-containers"))
          (hsPkgs."cryptonite" or (errorHandler.buildDepError "cryptonite"))
          (hsPkgs."deepseq" or (errorHandler.buildDepError "deepseq"))
          (hsPkgs."heapwords" or (errorHandler.buildDepError "heapwords"))
          (hsPkgs."memory" or (errorHandler.buildDepError "memory"))
          (hsPkgs."nothunks" or (errorHandler.buildDepError "nothunks"))
          (hsPkgs."primitive" or (errorHandler.buildDepError "primitive"))
          (hsPkgs."serialise" or (errorHandler.buildDepError "serialise"))
          (hsPkgs."template-haskell" or (errorHandler.buildDepError "template-haskell"))
          (hsPkgs."th-compat" or (errorHandler.buildDepError "th-compat"))
          (hsPkgs."text" or (errorHandler.buildDepError "text"))
          (hsPkgs."transformers" or (errorHandler.buildDepError "transformers"))
          (hsPkgs."vector" or (errorHandler.buildDepError "vector"))
          ] ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "9.0.0") (hsPkgs."integer-gmp" or (errorHandler.buildDepError "integer-gmp"));
        pkgconfig = [
          (pkgconfPkgs."libsodium" or (errorHandler.pkgConfDepError "libsodium"))
          ] ++ (pkgs.lib).optional (flags.secp256k1-support) (pkgconfPkgs."libsecp256k1" or (errorHandler.pkgConfDepError "libsecp256k1"));
        buildable = true;
        };
      tests = {
        "test-memory-example" = {
          depends = [
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
            (hsPkgs."cardano-crypto-class" or (errorHandler.buildDepError "cardano-crypto-class"))
            ] ++ (pkgs.lib).optional (system.isLinux || system.isOsx) (hsPkgs."unix" or (errorHandler.buildDepError "unix"));
          buildable = true;
          };
        };
      };
    } // {
    src = (pkgs.lib).mkDefault (pkgs.fetchurl {
      url = "https://input-output-hk.github.io/cardano-haskell-packages/package/cardano-crypto-class-2.0.0.1.tar.gz";
      sha256 = "50ee8ec136b95ebfe2b2e1d954b0a42ac2f73faf562eda42b85708314a324227";
      });
    }) // {
    package-description-override = "cabal-version:      2.2\nname:               cardano-crypto-class\nversion:            2.0.0.1\nsynopsis:\n  Type classes abstracting over cryptography primitives for Cardano\n\ndescription:\n  Type classes abstracting over cryptography primitives for Cardano\n\nlicense:            Apache-2.0\nlicense-files:\n  LICENSE\n  NOTICE\n\nauthor:             IOHK\nmaintainer:         operations@iohk.io\ncopyright:          2019-2021 IOHK\ncategory:           Currency\nbuild-type:         Simple\nextra-source-files: README.md\n\nflag development\n  description: Disable `-Werror`\n  default:     False\n  manual:      True\n\nflag secp256k1-support\n    description: Enable support for functions from libsecp256k1. Requires\n                 a recent libsecp256k1 with support for Schnorr signatures.\n    default: True\n    manual: True\n\ncommon base                         { build-depends: base >= 4.14 && < 4.17 }\n\ncommon project-config\n  default-language: Haskell2010\n  ghc-options:\n    -Wall -Wcompat -Wincomplete-record-updates\n    -Wincomplete-uni-patterns -Wpartial-fields -Wredundant-constraints\n    -Wunused-packages\n\nlibrary\n  import:            base, project-config\n  hs-source-dirs:    src\n  exposed-modules:\n    Cardano.Crypto.DSIGN\n    Cardano.Crypto.DSIGN.Class\n    Cardano.Crypto.DSIGN.Ed25519\n    Cardano.Crypto.DSIGN.Ed448\n    Cardano.Crypto.DSIGN.Mock\n    Cardano.Crypto.DSIGN.NeverUsed\n    Cardano.Crypto.Hash\n    Cardano.Crypto.Hash.Blake2b\n    Cardano.Crypto.Hash.Class\n    Cardano.Crypto.Hash.Keccak256\n    Cardano.Crypto.Hash.NeverUsed\n    Cardano.Crypto.Hash.SHA256\n    Cardano.Crypto.Hash.SHA3_256\n    Cardano.Crypto.Hash.Short\n    Cardano.Crypto.Init\n    Cardano.Crypto.KES\n    Cardano.Crypto.KES.Class\n    Cardano.Crypto.KES.CompactSingle\n    Cardano.Crypto.KES.CompactSum\n    Cardano.Crypto.KES.Mock\n    Cardano.Crypto.KES.NeverUsed\n    Cardano.Crypto.KES.Simple\n    Cardano.Crypto.KES.Single\n    Cardano.Crypto.KES.Sum\n    Cardano.Crypto.Libsodium\n    Cardano.Crypto.Libsodium.C\n    Cardano.Crypto.Libsodium.Constants\n    Cardano.Crypto.Libsodium.Hash\n    Cardano.Crypto.Libsodium.Init\n    Cardano.Crypto.Libsodium.Memory\n    Cardano.Crypto.Libsodium.Memory.Internal\n    Cardano.Crypto.Libsodium.MLockedBytes\n    Cardano.Crypto.Libsodium.MLockedBytes.Internal\n    Cardano.Crypto.Libsodium.UnsafeC\n    Cardano.Crypto.PinnedSizedBytes\n    Cardano.Crypto.Seed\n    Cardano.Crypto.Util\n    Cardano.Crypto.VRF\n    Cardano.Crypto.VRF.Class\n    Cardano.Crypto.VRF.Mock\n    Cardano.Crypto.VRF.NeverUsed\n    Cardano.Crypto.VRF.Simple\n    Cardano.Foreign\n\n  other-modules:\n    Cardano.Crypto.PackedBytes\n\n  build-depends:\n    , aeson\n    , base\n    , base16-bytestring  >=1\n    , bytestring\n    , cardano-binary\n    , cardano-strict-containers\n    , cryptonite\n    , deepseq\n    , heapwords\n    , memory\n    , nothunks\n    , primitive\n    , serialise\n    , template-haskell\n    , th-compat\n    , text\n    , transformers\n    , vector\n\n  if impl(ghc < 9.0.0)\n    build-depends:\n      integer-gmp\n\n  pkgconfig-depends: libsodium -any\n\n  if flag(secp256k1-support)\n    exposed-modules:\n      Cardano.Crypto.DSIGN.EcdsaSecp256k1\n      Cardano.Crypto.DSIGN.SchnorrSecp256k1\n      Cardano.Crypto.SECP256K1.Constants\n      Cardano.Crypto.SECP256K1.C\n    pkgconfig-depends: libsecp256k1 -any\n    cpp-options: -DSECP256K1_ENABLED\n\ntest-suite test-memory-example\n  import:         base, project-config\n  type:           exitcode-stdio-1.0\n  hs-source-dirs: memory-example\n  main-is:        Main.hs\n  build-depends:\n    , base\n    , bytestring\n    , cardano-crypto-class\n\n  if (os(linux) || os(osx))\n    build-depends: unix\n";
    }