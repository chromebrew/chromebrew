require 'buildsystems/autotools'

class Apr < Autotools
  description 'The mission of the Apache Portable Runtime (APR) project is to create and maintain software libraries that provide a predictable and consistent interface to underlying platform-specific implementations.  APR is the base portability library.'
  homepage 'https://apr.apache.org/'
  version '1.7.4'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://dlcdn.apache.org/apr/apr-1.7.4.tar.bz2'
  source_sha256 'fc648de983f3a2a6c9e78dea1f180639bd2fad6c06d556d4367a701fe5c35577'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd412d8dd1ca6fac9d86b6f4fbbc78b39b5902ac605120bf2baee81b3945db9c7',
     armv7l: 'd412d8dd1ca6fac9d86b6f4fbbc78b39b5902ac605120bf2baee81b3945db9c7',
       i686: 'b9a87b935a3585dbab5bc3b6a476a106fe6b433d37c7b32934b41e706b28604f',
     x86_64: 'c9dd5b5505bf47f490f887d48131508d149b342076f1d41e11b5491037311781'
  })

  # https://bz.apache.org/bugzilla/show_bug.cgi?id=63439
  configure_options '--with-devrandom --without-sendfile --enable-layout=GNU'
end
