require 'package'

class Zstd < Package
  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'http://www.zstd.net'
  @_ver = '1.4.9'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/facebook/zstd/archive/v#{@_ver}.tar.gz"
  source_sha256 'acf714d98e3db7b876e5b540cbf6dee298f60eb3c0723104f6d3f065cd60d6a8'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/zstd-1.4.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/zstd-1.4.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/zstd-1.4.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/zstd-1.4.9-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c94ef7aecad9675d4fdcfc444cfd74c1560f6f8090c851bffe2be2a5250fc4f9',
     armv7l: 'c94ef7aecad9675d4fdcfc444cfd74c1560f6f8090c851bffe2be2a5250fc4f9',
       i686: 'd59795e6cc367cfb9120e4a7b60df706cfd1746c5b41485767cf2ff75eddb2cb',
     x86_64: '055c10b86abdb5268f90c28f73ccb7cc1db155ef7d7e14fba97a977ed3886832'
  })

  def self.patch
    # Patch from https://github.com/facebook/zstd/issues/2519#issuecomment-790092538
    @meson_patch = <<~'MESON_PATCH_EOF'
      --- a/build/meson/lib/meson.build~      2021-03-02 22:20:57.000000000 +0000
      +++ b/build/meson/lib/meson.build       2021-03-03 21:56:00.058700361 +0000
      @@ -22,6 +22,7 @@
         join_paths(zstd_rootdir, 'lib/common/threading.c'),
         join_paths(zstd_rootdir, 'lib/common/pool.c'),
         join_paths(zstd_rootdir, 'lib/common/zstd_common.c'),
      +  join_paths(zstd_rootdir, 'lib/common/zstd_trace.c'),
         join_paths(zstd_rootdir, 'lib/common/error_private.c'),
         join_paths(zstd_rootdir, 'lib/common/xxhash.c'),
         join_paths(zstd_rootdir, 'lib/compress/hist.c'),
    MESON_PATCH_EOF
    IO.write('meson.patch', @meson_patch)
    system 'patch -p1 -i meson.patch'
  end

  def self.build
    Dir.chdir 'build/meson' do
      system "meson \
        #{CREW_MESON_LTO_OPTIONS} \
        builddir"
      system 'meson configure builddir'
      system 'ninja -C builddir'
    end
  end

  def self.install
    Dir.chdir 'build/meson' do
      system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    end
  end
end
