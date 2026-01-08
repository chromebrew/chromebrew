require 'buildsystems/cmake'

class Xzutils < CMake
  description 'XZ Utils is free general-purpose data compression software with a high compression ratio.'
  homepage 'https://tukaani.org/xz/'
  version '5.8.2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/tukaani-project/xz.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6c54532c166ac31d4892c295e90120faa2cdc7de5fe219312408b4ef43c096bd',
     armv7l: '6c54532c166ac31d4892c295e90120faa2cdc7de5fe219312408b4ef43c096bd',
       i686: '1e30cc74fc0fae110561cda9ddec45125b766b49c710a596dcab2b531367983e',
     x86_64: '894bae0c7a402a7f191b8df6c290d391ec35d1f399d350e3027d93cb6ff36fb2'
  })

  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'

  cmake_install_extras do
    # Imagemagick & Graphicsmagick want a libtool file.
    ConvenienceFunctions.libtoolize('lzma', 'xzutils', true)
  end
end
