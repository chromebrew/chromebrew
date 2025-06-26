require 'buildsystems/meson'

class Libeconf < Meson
  description 'Enhanced config file parser, which merges config files placed in several locations into one.'
  homepage 'https://github.com/openSUSE/libeconf'
  version '0.7.9'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/openSUSE/libeconf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9e47b82c8c419a2674e531fcc4227df55eb1a2b2d6941927c77885e67099ef9d',
     armv7l: '9e47b82c8c419a2674e531fcc4227df55eb1a2b2d6941927c77885e67099ef9d',
       i686: 'ada290c52e6796db77221f78cbc39c1f82551af108516733e63d7db722e4b867',
     x86_64: '0566bfa9e58839df70bfe216e3d76bd04aaca6ce5825a71b5add1eae98930c21'
  })

  depends_on 'glibc' # R
  depends_on 'gcc_lib' # R
end
