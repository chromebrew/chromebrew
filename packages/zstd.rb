require 'buildsystems/cmake'

class Zstd < CMake
  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'https://facebook.github.io/zstd/'
  version '1.5.7' # Do not use @_ver here, it will break the installer.
  license 'BSD or GPL-2'
  compatibility 'all'
  source_url 'https://github.com/facebook/zstd.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd8aca7c753c8f4a1663de9904a41d73c8905e1d04dfb90f48e0c9850b3170d2a',
     armv7l: 'd8aca7c753c8f4a1663de9904a41d73c8905e1d04dfb90f48e0c9850b3170d2a',
       i686: 'ecb3af46cb98143970f9f59ce1503b6401d762d4f4027aa3d7e40781dad4191d',
     x86_64: '99908d616f54001466cb447fafe72d5cccde07cbff2ea7c1f505ffeb0d100c30'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'lz4' => :executable
  depends_on 'xzutils' => :executable
  depends_on 'zlib' => :executable

  conflicts_ok # Conflicts with zstd_static.
  run_tests

  def self.patch
    # Fix missing man updates as per https://github.com/facebook/zstd/releases/tag/v1.5.7
    downloader 'https://github.com/facebook/zstd/commit/6af3842118ea5325480b403213b2a9fbed3d3d74.diff', '505a0dc5d6b9a3e6d5eba26a90dfc6b488908bbd8a616229aa4f4a04c357883b'
    system 'patch -Np1 -i 6af3842118ea5325480b403213b2a9fbed3d3d74.diff'
  end

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
