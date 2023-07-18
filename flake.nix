{
   inputs = {
       nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
       flake-utils.url = "github:numtide/flake-utils";

     };
     outputs = { self, nixpkgs, flake-utils, ... }:
         flake-utils.lib.eachDefaultSystem (system:
             let
                 pkgs = import nixpkgs { inherit system; };
                 #go-protobuf = pkgs.buildGoModule rec {
                 #pname = "go-protobuf";
                 #version = "v1.4.2";

                 #src = pkgs.fetchFromGitHub {
                 #  owner = "golang";
                 #  repo = "protobuf";
                 #  rev = "v1.4.2";
                 #  sha256 = "0m5z81im4nsyfgarjhppayk4hqnrwswr3nix9mj8pff8x9jvcjqw";
                 #};

                 #modSha256 = "0lnk1zpl6y9vnq6h3l42ssghq6iqvmixd86g2drpa4z8xxk116wf";

                 #subPackages = [ "protoc-gen-go" ];
                 #};
                protoc-gen-go-grpc = pkgs.buildGoModule {
                  name = "protoc-gen-go-grpc";
                  src = pkgs.fetchFromGitHub {
                    owner = "grpc";
                    repo = "grpc-go";
                    rev = "v1.36.0";
                    sha256 = "sha256-sUDeWY/yMyijbKsXDBwBXLShXTAZ4445I4hpP7bTndQ=";
                  };
                  doCheck = false;
                  vendorSha256 = "sha256-KHd9zmNsmXmc2+NNtTnw/CSkmGwcBVYNrpEUmIoZi5Q=";
                  modRoot = "./cmd/protoc-gen-go-grpc";
                };

                protoc-gen-go = pkgs.buildGoModule {
                  name = "protoc-gen-go";
                  src = pkgs.fetchFromGitHub {
                    owner = "protocolbuffers";
                    repo = "protobuf-go";
                    rev = "v1.27.1";
                    sha256 = "sha256-wkUvMsoJP38KMD5b3Fz65R1cnpeTtDcVqgE7tNlZXys=";
                  };
                  doCheck = false;
                  vendorSha256 = null;
                  modRoot = "./cmd/protoc-gen-go";
                };

              in {
                  devShell = pkgs.mkShellNoCC {
                      buildInputs =
                          [
                            pkgs.openssl
                            pkgs.protobuf
                            pkgs.gnumake
                            pkgs.nix
                            pkgs.git
                            pkgs.go_1_20
                            pkgs.mockgen
                            pkgs.gopls
                            pkgs.gotools
                            pkgs.go-tools
                            protoc-gen-go
                            protoc-gen-go-grpc
                          ];

                    };
              });
}
