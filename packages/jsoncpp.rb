require 'buildsystems/meson'

class Jsoncpp < Meson
  description 'A C++ library for interacting with JSON.'
  homepage 'https://github.com/open-source-parsers/jsoncpp'
  version '1.9.6'
  license 'MIT, public-domain'
  compatibility 'all'
  source_url 'https://github.com/open-source-parsers/jsoncpp.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '01e997a3880d387a8bfcdb62427ba1d7604c43e0485444a8a9fe2f23bf6beae9',
     armv7l: '01e997a3880d387a8bfcdb62427ba1d7604c43e0485444a8a9fe2f23bf6beae9',
       i686: '6e5b6c697c6e430853e90ba134ec81ee5de299e165957baf70aca7052bc32f3f',
     x86_64: 'f67495de6609cc004c4312c93cc9f64ee6bc0d713fb87242a0b92a65b3fed80a'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
