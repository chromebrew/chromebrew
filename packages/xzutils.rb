require 'buildsystems/cmake'

class Xzutils < CMake
  description 'XZ Utils is free general-purpose data compression software with a high compression ratio.'
  homepage 'https://tukaani.org/xz/'
  version '5.8.1-3'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/tukaani-project/xz.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '704d9231ca3a3aacf710b32049d9e96e5efcd6afc4446c2f7d73ca7efe177f2c',
     armv7l: '704d9231ca3a3aacf710b32049d9e96e5efcd6afc4446c2f7d73ca7efe177f2c',
       i686: '6135be59adfa169b7517a731ae532841999b26cb44acd77bb153e400c6d574fd',
     x86_64: '11efc5d59ab7b1c7acdef3c0bf7f4ebb89129bddef7fd753169d6468c6b07ec7'
  })

  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'

  cmake_install_extras do
    # Imagemagick & Graphicsmagick want a libtool file.
    ConvenienceFunctions.libtoolize('lzma', 'xzutils', true)
  end
end
