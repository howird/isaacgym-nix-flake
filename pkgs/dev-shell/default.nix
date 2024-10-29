{ mkShell
, python38
}:

mkShell rec {
  name = "isaacgym";

  packages = [
    (python38.withPackages (p: with p; [
      isaacgym
    ]))
  ];
}
