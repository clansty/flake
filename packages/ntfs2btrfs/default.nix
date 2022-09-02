{ stdenv
, fetchurl
, lib
, cmake, fmt_8, pkg-config, zlib, lzo, zstd
, ...
} @ args:

stdenv.mkDerivation rec {
  pname = "ntfs2btrfs";
  version = "20220812";
  src = fetchurl {
    url = "https://github.com/maharmstone/${pname}/archive/refs/tags/${version}.tar.gz";
    sha256 = "nOB1NeYZGrRfIEpN0oG+R2jXkX30Qm7nxxqpwwii/pM=";
  };

  nativeBuildInputs = [ cmake fmt_8 pkg-config zlib lzo zstd ];
}
