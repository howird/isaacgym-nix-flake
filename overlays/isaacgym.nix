final: prev: {
  # python3 = prev.python38.override {
  #   extraLibs = with prev.python38Packages; [
  #     numpy
  #     pybind11
  #   ];
  # };
  python3 = final.python38;
  python3Packages = final.python38Packages.override {
    overrides = pypackages-final: pypackages-prev: {
      isaacgym = prev.callPackage ../pkgs/isaacgym {};
    };
  };

  # pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
  #   (python-final: python-prev: {
  #     isaacgym = python-final.callPackage ../pkgs/isaacgym {};
  #   })
  # ];
  # isaacgym = prev.python38Packages.buildPythonPackage 
}
