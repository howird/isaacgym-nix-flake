{ lib
, buildPythonPackage
, requireFile
, fetchzip
, python38
, setuptools
, python38Packages
}:

buildPythonPackage rec {
  pname = "isaacgym";
  version = "1.0.preview4";

  src = requireFile {
    url = "https://developer.nvidia.com/isaac-gym/download";
    name = "IsaacGym_Preview_4_Package.tar.gz";
    # nix-store --add-fixed sha256 /path/to/IsaacGym_Preview_4_Package.tar.gz
    # nix hash-file --type sha256 /path/to/IsaacGym_Preview_4_Package.tar.gz
    hash = "sha256-xR13rBFEuRs1b0OccxPY1ZRoFH43GH6//nzbwxVP248=";
  };

  build-system = with python38Packages; [
    setuptools
  ];

  patchPhase = ''
    cp -R python/* .
  '';

  buildInputs = with python38Packages; [
    numpy
    torch
    torchvision
    scipy
    imageio
    ninja
  ];

    # "torch>=1.8.0",
    # "torchvision>=0.9.0",
    # "numpy>=1.16.4",
    # "scipy>=1.5.0",
    # "pyyaml>=5.3.1",
    # "pillow",
    # "imageio",
    # "ninja",

  meta = with lib; {
    description = "NVIDIA’s prototype physics simulation environment for end-to-end GPU accelerated reinforcement learning research.";
    homepage = "https://developer.nvidia.com/isaac-gym";
    license = licenses.unfree;
    # maintainers = with maintainers; [ breakds ];
  };
}
