require 'buildsystems/cmake'

class Xzutils < CMake
  description 'XZ Utils is free general-purpose data compression software with a high compression ratio.'
  homepage 'https://tukaani.org/xz/'
  version '5.8.3'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/tukaani-project/xz.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '78d2a973ea000041a5b15d2d910d8cc0bcc60cef388fcf05f291d23f90ea659a',
     armv7l: '78d2a973ea000041a5b15d2d910d8cc0bcc60cef388fcf05f291d23f90ea659a',
       i686: '0e826bf21fa219ac0bdd622c665a46652ea710c224c9e52b02bc8982dfd8ac8a',
     x86_64: 'c8b8c1562aad0ae952dfaaa335bfc91738f581ce2fbbc680cf5f0021d7edc8df'
  })

  depends_on 'glibc' => :library

  cmake_options '-DBUILD_SHARED_LIBS=ON'

  cmake_install_extras do
    # Imagemagick & Graphicsmagick want a libtool file.
    ConvenienceFunctions.libtoolize('lzma', 'xzutils', true)
  end
end
