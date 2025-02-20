require 'buildsystems/cmake'

class Zstd < CMake

  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'https://facebook.github.io/zstd/'
  version '1.5.7' # Do not use @_ver here, it will break the installer.
  license 'BSD or GPL-2'
  compatibility 'all'
  source_url 'https://github.com/facebook/zstd.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'fcef09c11c9fa7ce65b4c81fe3622343311bae1ea3e79d0efbd109e6d154174e',
     armv7l: 'fcef09c11c9fa7ce65b4c81fe3622343311bae1ea3e79d0efbd109e6d154174e',
       i686: '1877238675dacf9f79d22f1093825759ea9d5921b7648a44f26b0a05d87618bf',
     x86_64: 'bc5f4c725cf5302933a4b6aa0e6a1c7ac18b8a0da6d01654c95556eb88b5da45'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'lz4' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R

  no_zstd
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
