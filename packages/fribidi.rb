require 'buildsystems/meson'

class Fribidi < Meson
  description 'GNU FriBidi is an implementation of the Unicode Bidirectional Algorithm (bidi).'
  homepage 'https://github.com/fribidi/fribidi'
  version '1.0.17'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/fribidi/fribidi.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4f0cca3b699872b337c2b6cf110a26c6645a196b1939570acbef9cba9e224f75',
     armv7l: '4f0cca3b699872b337c2b6cf110a26c6645a196b1939570acbef9cba9e224f75',
       i686: '4b00c8938234cc9d8435e775d1aa7a8993e575d19f773df40df9be09a6cad08d',
     x86_64: '065bc01cb3f643b7bbf7dea7f55481e5ecd83797a7782ab4ba23df6cc823d7b2'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  meson_options '-Ddocs=false \
      -Dtests=false'
end
