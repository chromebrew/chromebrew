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
    aarch64: 'cf90019b34a1b8c577934a6a0e9a5c19f9a464c0384b8370a45810d466dd90d3',
     armv7l: 'cf90019b34a1b8c577934a6a0e9a5c19f9a464c0384b8370a45810d466dd90d3',
       i686: 'ada290c52e6796db77221f78cbc39c1f82551af108516733e63d7db722e4b867',
     x86_64: '0566bfa9e58839df70bfe216e3d76bd04aaca6ce5825a71b5add1eae98930c21'
  })

  depends_on 'glibc' # R
  depends_on 'gcc_lib' # R
end
