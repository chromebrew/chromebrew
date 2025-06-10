require 'buildsystems/cmake'

class Xzutils < CMake
  description 'XZ Utils is free general-purpose data compression software with a high compression ratio.'
  homepage 'https://tukaani.org/xz/'
  version '5.8.1-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/tukaani-project/xz.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '16872abfec2d0797904f3698b3b36303a2ef429a698895a0399e46f026a597ac',
     armv7l: '16872abfec2d0797904f3698b3b36303a2ef429a698895a0399e46f026a597ac',
       i686: '28e2cdca3c76952c24aba2b3422f67ec998da8e2024e61dd6e2dc8bceb74b09e',
     x86_64: 'ff88bac5d2a797c19314f7dd479446f732a2dd2934d1d91eb1791835afcb243c'
  })

  depends_on 'glibc' # R
  no_zstd

  cmake_options '-DBUILD_SHARED_LIBS=ON'

  cmake_install_extras do
    # Imagemagick wants a libtool file.
    ConvenienceFunctions.libtoolize('liblzma') unless ARCH.include?('i686')
  end
end
