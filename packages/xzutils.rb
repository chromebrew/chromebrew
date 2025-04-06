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
    aarch64: 'cd847a50db158b318521ac6a45cb4b582f2f4b942c14d1b661c5d9021dc08c59',
     armv7l: 'cd847a50db158b318521ac6a45cb4b582f2f4b942c14d1b661c5d9021dc08c59',
       i686: '74ee3967f67c75c56f59fc947df096aa52e9e2fe4d4a7a3251381e542098e04d',
     x86_64: '504e74934a72987f2db56dd5dc2fb344c09ca538ff574fe409b38daed3d03010'
  })

  depends_on 'glibc' # R
  no_zstd

  cmake_options '-DBUILD_SHARED_LIBS=ON'

  cmake_install_extras do
    # Imagemagick wants a libtool file.
    ConvenienceFunctions.libtoolize('liblzma') unless ARCH.include?('i686')
  end
end
