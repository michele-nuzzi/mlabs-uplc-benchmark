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
    flags = {};
    package = {
      specVersion = "1.10";
      identifier = { name = "size-based"; version = "0.1.3.2"; };
      license = "BSD-3-Clause";
      copyright = "(c) Jonas Duregård";
      maintainer = "byorgey@gmail.com";
      author = "Jonas Duregård";
      homepage = "";
      url = "";
      synopsis = "Sized functors, for size-based enumerations";
      description = "A framework for size-based enumerations. See the module documentation for details.";
      buildType = "Simple";
      };
    components = {
      "library" = {
        depends = [
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."dictionary-sharing" or (errorHandler.buildDepError "dictionary-sharing"))
          (hsPkgs."testing-type-modifiers" or (errorHandler.buildDepError "testing-type-modifiers"))
          (hsPkgs."template-haskell" or (errorHandler.buildDepError "template-haskell"))
          ];
        buildable = true;
        };
      };
    } // {
    src = (pkgs.lib).mkDefault (pkgs.fetchurl {
      url = "http://hackage.haskell.org/package/size-based-0.1.3.2.tar.gz";
      sha256 = "8250a66565a33e3d6c7f85a1ddfc851c96b3de790473644c84a6823de55502e2";
      });
    }) // {
    package-description-override = "name:                size-based\nversion:             0.1.3.2\nsynopsis:            Sized functors, for size-based enumerations\ndescription:         A framework for size-based enumerations. See the module documentation for details.\n\nlicense:             BSD3\nlicense-file:        LICENSE\nauthor:              Jonas Duregård\nmaintainer:          byorgey@gmail.com\ncopyright:           (c) Jonas Duregård\ncategory:            Data\nbuild-type:          Simple\ncabal-version:       >=1.10\nextra-source-files:  CHANGELOG.md\ntested-with:         GHC ==8.6.5 || ==8.8.4 || ==8.10.7 || ==9.0.2 || ==9.2.8 || ==9.4.7 || ==9.6.3 || ==9.8.1\n\nsource-repository head\n  type:      git\n  location:  https://github.com/size-based/size-based\n\nlibrary\n  exposed-modules:\n    Control.Sized\n    Control.Enumerable\n    Control.Enumerable.Count\n    Control.Enumerable.Values\n--    Control.Enumerable.Functions\n--    Control.Enumerable.LazySearch\n\n  other-modules:\n    Control.Enumerable.Derive\n  other-extensions:    GADTs, DeriveDataTypeable\n  build-depends:       base >=4.9 && <5,\n                       dictionary-sharing >= 0.1 && < 1.0,\n                       testing-type-modifiers >= 0.1 && < 1.0,\n                       template-haskell  >=2.5 && <2.22\n  default-language:    Haskell2010\n";
    }