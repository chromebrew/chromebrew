require 'package'

class Zstd < Package
  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'http://www.zstd.net'
  version '1.5.5' # Do not use @_ver here, it will break the installer.
  license 'BSD or GPL-2'
  compatibility 'all'
  source_url 'https://github.com/facebook/zstd.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.5_armv7l/zstd-1.5.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.5_armv7l/zstd-1.5.5-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.5_i686/zstd-1.5.5-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.5_x86_64/zstd-1.5.5-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'dff0cc50967894c3ad9876ff05a4d77c9eab3f5addaeaab5a17a1434965d9405',
     armv7l: 'dff0cc50967894c3ad9876ff05a4d77c9eab3f5addaeaab5a17a1434965d9405',
       i686: 'ea977e70ac582248beacc24191173b105ab220a330d53dc8aff23003f6242d5e',
     x86_64: '94355516d3bf8a75b4197d5c146d89ae7f1dae7f5e9042c2562c538bc48fda59'
  })

  depends_on 'glibc' # R
  depends_on 'gcc_lib' # R

  no_patchelf
  no_zstd

  def self.build
    Dir.chdir 'build/cmake' do
      system "cmake -B builddir #{CREW_CMAKE_OPTIONS} \
      -DZSTD_BUILD_STATIC=ON \
      -DZSTD_BUILD_SHARED=ON \
      -DZSTD_LEGACY_SUPPORT=ON \
      -DZSTD_BUILD_CONTRIB=ON \
      -DZSTD_PROGRAMS_LINK_SHARED=OFF \
      -G Ninja"
      system 'samu -C builddir'
    end
  end

  def self.install
    Dir.chdir 'build/cmake' do
      system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
    end
    # Convert symlinks to hard links in libdir.
    Dir.chdir CREW_DEST_LIB_PREFIX do
      Dir['*'].each do |f|
        FileUtils.ln File.realpath(f), f, force: true if File.symlink?(f)
      end
    end
  end
end
