{
  lib,
  stdenvNoCC,
  steamcmd,
}: {
  name,
  appId,
  workshopId ? null,
  branch ? null,
  hash,
}:
stdenvNoCC.mkDerivation {
  name = "${name}-src";
  inherit appId workshopId branch;
  builder = ./builder.sh;
  buildInputs = [
    steamcmd
  ];

  outputHash = hash;
  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
}
