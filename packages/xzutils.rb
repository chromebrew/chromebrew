require 'buildsystems/cmake'

class Xzutils < CMake
  description 'XZ Utils is free general-purpose data compression software with a high compression ratio.'
  homepage 'https://tukaani.org/xz/'
  version '5.8.1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/tukaani-project/xz.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'e4c4b9c1a59ae7774101a941fe527d6a323a95e85c01daaa5ce8c3343d6ecc41',
     armv7l: 'e4c4b9c1a59ae7774101a941fe527d6a323a95e85c01daaa5ce8c3343d6ecc41',
       i686: '2c4a789b305079c2954cc2074cb0e11698f62099aafe57c53d03500794bb6857',
     x86_64: '63b13e9172413d31639b36d92f6f439670105a43d9b67b61080e21c444b57a5d'
  })

  depends_on 'glibc' # R
  no_zstd

  cmake_options '-DBUILD_SHARED_LIBS=ON'

  cmake_install_extras do
    # Imagemagick wants a libtool file.
    ConvenienceFunctions.libtoolize('liblzma') unless ARCH.include?('i686')
  end
end
