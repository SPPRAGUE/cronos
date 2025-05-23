{
  runCommand,
  windows,
  stdenv,
  rocksdb,
  bzip2,
  lz4,
  snappy,
  zstd,
  zlib,
  cronosd,
}:
runCommand "tarball-${cronosd.name}"
  {
    # manually enumerate the runtime dependencies of cronosd on mingwW64
    deps = [
      "${rocksdb}/bin/librocksdb-shared.dll"
      "${snappy}/bin/libsnappy.dll"
      "${lz4.out}/bin/liblz4.dll"
      "${bzip2.bin}/bin/libbz2-1.dll"
      "${zlib}/bin/zlib1.dll"
      "${zstd.bin}/bin/libzstd.dll"
      "${windows.mingw_w64_pthreads}/bin/libwinpthread-1.dll"
      "${windows.mcfgthreads}/bin/libmcfgthread-1.dll"
      "${stdenv.cc.cc.lib}/x86_64-w64-mingw32/lib/libgcc_s_seh-1.dll"
      "${stdenv.cc.cc.lib}/x86_64-w64-mingw32/lib/libstdc++-6.dll"
    ];
  }
  ''
    mkdir -p $out
    for so in $deps
    do
      cp $so $out/
    done

    cp ${cronosd}/bin/${cronosd.meta.mainProgram} $out/
  ''
