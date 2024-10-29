{
  description = "Provide extra Nix packages for Machine Learning and Data Science";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/23.11";
    nixpkgs.url = "github:NixOS/nixpkgs/6f05cfdb1e78d36c0337516df674560e4b51c79b";
    # nixpkgs.url = "github:NixOS/nixpkgs/a801c31fa47618d4fd27ee4c15d4c58b5ae60cae";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    overlays = rec {
      isaacgym = import ./overlays/isaacgym.nix;
      default = isaacgym;
    };
  } // inputs.utils.lib.eachSystem [
    "x86_64-linux"
  ] (system:
    let pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            cudaSupport = true;
            # ChatGPT: When you compile a CUDA program, you can specify for
            # which Compute Capability you want to build it. The resulting
            # binary code will be optimized for that specific version of Compute
            # Capability, and it won't run on GPUs with lower Compute
            # Capability. If you want your CUDA program to be able to run on
            # different GPUs, you should compile it for the lowest Compute
            # Capability you intend to support.
            #
            # 7.5 - 20X0 (Ti), T4
            # 8.0 - A100
            # 8.6 - 30X0 (Ti)
            # 8.9 - 40X0 (Ti)
            cudaCapabilities = [ "7.5" "8.6" ];
            cudaForwardCompat = true;
          };
          overlays = [
            self.overlays.default
          ];
        };
    in rec {
      devShells = {
        default = pkgs.callPackage ./pkgs/dev-shell {};
      };

      packages = {
        default = pkgs.python3.packages.isaacgym;
      };
    });
}
