require 'package'

class Zstd < Package
  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'http://www.zstd.net'
  version '3298a08076081dbfa8eba5b08c2167b06020c5ff' # Do not use @_ver here, it will break the installer.
  license 'BSD or GPL-2'
  compatibility 'all'
  source_url 'https://github.com/facebook/zstd.git'
  git_hashtag version
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/3298a08076081dbfa8eba5b08c2167b06020c5ff_armv7l/zstd-3298a08076081dbfa8eba5b08c2167b06020c5ff-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/3298a08076081dbfa8eba5b08c2167b06020c5ff_armv7l/zstd-3298a08076081dbfa8eba5b08c2167b06020c5ff-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/3298a08076081dbfa8eba5b08c2167b06020c5ff_i686/zstd-3298a08076081dbfa8eba5b08c2167b06020c5ff-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/3298a08076081dbfa8eba5b08c2167b06020c5ff_x86_64/zstd-3298a08076081dbfa8eba5b08c2167b06020c5ff-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '1c12e49396d6df5bc42ca922ab19481d844683b64521e1878cc592e538c2c8f5',
     armv7l: '1c12e49396d6df5bc42ca922ab19481d844683b64521e1878cc592e538c2c8f5',
       i686: '7ec849b9ebb7530985a97d842543fdd442631f021c163dc0368a1ad369fc4b03',
     x86_64: '051221f5402a60ca9dd040b762b8cc1822a6c6099f7eece38041d3e0a736381c'
  })

  depends_on 'glibc' # R
  depends_on 'gcc_lib' # R
  depends_on 'zlibpkg' # R

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
      system "#{CREW_NINJA} -C builddir"
    end
    system 'make -C tests'
  end

  def self.check
    system 'make -C tests check'
  end

  def self.install
    Dir.chdir 'build/cmake' do
      system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    end
    # Convert symlinks to hard links in libdir.
    Dir.chdir CREW_DEST_LIB_PREFIX do
      Dir['*'].each do |f|
        FileUtils.ln File.realpath(f), f, force: true if File.symlink?(f)
      end
    end
  end
end
