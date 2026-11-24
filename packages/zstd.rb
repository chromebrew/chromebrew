require 'buildsystems/cmake'

class Zstd < CMake
  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'https://facebook.github.io/zstd/'
  version '1.6.0' # Do not use @_ver here, it will break the installer.
  license 'BSD or GPL-2'
  compatibility 'all'
  source_url 'https://github.com/facebook/zstd.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '41f01d4b98e4a6c22382765abf723bf1ba52909f5104ccc8697d5fb7477821ea',
     armv7l: '41f01d4b98e4a6c22382765abf723bf1ba52909f5104ccc8697d5fb7477821ea',
       i686: '863b16d8c40413210462900603fa1343d84cf32732a45b55a34bf43eaeebe5ba',
     x86_64: 'c77dfd3bb27c44a86e38efc341e8cb35f38d7e4da69fe05ce2825257679c169d'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'lz4' => :executable
  depends_on 'xzutils' => :executable
  depends_on 'zlib' => :executable

  conflicts_ok # Conflicts with zstd_static.
  run_tests

  cmake_build_relative_dir 'build/cmake'
  cmake_options '-DZSTD_LZ4_SUPPORT=ON \
      -DZSTD_LZMA_SUPPORT=ON \
      -DZSTD_ZLIB_SUPPORT=ON \
      -DZSTD_BUILD_STATIC=ON \
      -DZSTD_BUILD_SHARED=ON \
      -DZSTD_BUILD_TESTS=ON \
      -DZSTD_LEGACY_SUPPORT=ON \
      -DZSTD_BUILD_CONTRIB=ON \
      -DZSTD_PROGRAMS_LINK_SHARED=OFF'

  cmake_install_extras do
    # Convert symlinks to hard links in libdir.
    Dir.chdir CREW_DEST_LIB_PREFIX do
      Dir['*'].each do |f|
        FileUtils.ln File.realpath(f), f, force: true if File.symlink?(f)
      end
    end
  end
end
