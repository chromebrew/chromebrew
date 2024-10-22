require 'package'

class Zstd < Package
  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'https://facebook.github.io/zstd/'
  version '1.5.6-1' # Do not use @_ver here, it will break the installer.
  license 'BSD or GPL-2'
  compatibility 'all'
  source_url 'https://github.com/facebook/zstd.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'fcef09c11c9fa7ce65b4c81fe3622343311bae1ea3e79d0efbd109e6d154174e',
     armv7l: 'fcef09c11c9fa7ce65b4c81fe3622343311bae1ea3e79d0efbd109e6d154174e',
       i686: '6a1af809ce6d0fc507b1b857b8f0803c6aded4e816d3c454e4e59b0f5ed4acca',
     x86_64: 'bc5f4c725cf5302933a4b6aa0e6a1c7ac18b8a0da6d01654c95556eb88b5da45'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'lz4' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R

  no_zstd

  def self.build
    Dir.chdir 'build/cmake' do
      system "cmake -B builddir #{CREW_CMAKE_OPTIONS} \
      -DZSTD_LZ4_SUPPORT=ON \
      -DZSTD_LZMA_SUPPORT=ON \
      -DZSTD_ZLIB_SUPPORT=ON \
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
