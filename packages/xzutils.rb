require 'buildsystems/cmake'

class Xzutils < CMake
  description 'XZ Utils is free general-purpose data compression software with a high compression ratio.'
  homepage 'https://tukaani.org/xz/'
  version '5.8.4'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/tukaani-project/xz.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bfb9adbcc090e0976a5f2f3febd13e802815d50074e4b13b91258c14ab14e467',
     armv7l: 'bfb9adbcc090e0976a5f2f3febd13e802815d50074e4b13b91258c14ab14e467',
       i686: '3b0dc5d0dc947d9d3494f6401df59523e546e26ffc856161538d3cf784a51fcf',
     x86_64: '3ea2f82f068e3c3bafe79e5774db60ce13a7e3de213a94a686d43670bcca1d85'
  })

  depends_on 'glibc' => :library

  cmake_options '-DBUILD_SHARED_LIBS=ON'

  cmake_install_extras do
    # Imagemagick & Graphicsmagick want a libtool file.
    ConvenienceFunctions.libtoolize('lzma', 'xzutils', install_dest: true)
  end
end
