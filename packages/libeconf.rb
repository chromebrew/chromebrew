require 'buildsystems/meson'

class Libeconf < Meson
  description 'Enhanced config file parser, which merges config files placed in several locations into one.'
  homepage 'https://github.com/openSUSE/libeconf'
  version '0.5.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/openSUSE/libeconf/archive/v0.5.2.tar.gz'
  source_sha256 'c9aa04b7ef1c7312a6e045184d15465db1985abb4058cc4c562fd33c9876bb34'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cf90019b34a1b8c577934a6a0e9a5c19f9a464c0384b8370a45810d466dd90d3',
     armv7l: 'cf90019b34a1b8c577934a6a0e9a5c19f9a464c0384b8370a45810d466dd90d3',
       i686: 'b838ed7b8184cb357ef6866ae0b144b8289bb6004c8921e1dc03a6c3bc931a08',
     x86_64: '04e050e45547fbde8fb42303748d67d4ca0e15bd911f2326241445ff20f3b17e'
  })

  depends_on 'glibc' # R
  depends_on 'gcc_lib' # R
end
