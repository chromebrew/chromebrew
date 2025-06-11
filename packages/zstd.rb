require 'buildsystems/cmake'

class Zstd < CMake
  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'https://facebook.github.io/zstd/'
  version '1.5.7-1' # Do not use @_ver here, it will break the installer.
  license 'BSD or GPL-2'
  compatibility 'all'
  source_url 'https://github.com/facebook/zstd.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2dac985dde40b14ba7d3c849c38873e56a1dfb19d44bd78f2b550f1322b6a059',
     armv7l: '2dac985dde40b14ba7d3c849c38873e56a1dfb19d44bd78f2b550f1322b6a059',
       i686: 'be95bd15d5ec848496d4a574eb72e764c526622be235287308adeffe19099ec8',
     x86_64: '1549e818ef9ecd1cbd33aa8322aaaacaceda3c8b4a422e990b8ed8d273f4e8db'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'lz4' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R

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
