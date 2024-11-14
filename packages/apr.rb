require 'buildsystems/autotools'

class Apr < Autotools
  description 'The mission of the Apache Portable Runtime (APR) project is to create and maintain software libraries that provide a predictable and consistent interface to underlying platform-specific implementations.  APR is the base portability library.'
  homepage 'https://apr.apache.org/'
  version '1.7.4-1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://dlcdn.apache.org/apr/apr-1.7.4.tar.bz2'
  source_sha256 'fc648de983f3a2a6c9e78dea1f180639bd2fad6c06d556d4367a701fe5c35577'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '465f8cada526545e28103e254f21d2ad628833b769abe5862e6830c72145efd6',
     armv7l: '465f8cada526545e28103e254f21d2ad628833b769abe5862e6830c72145efd6',
       i686: 'ee88e192864d2aafb8e508b5a8ddda2bd660cc3657b77860339fae080ab81c57',
     x86_64: '535c8ec82c9ac8b3f51e23fcb053a51d69a0c8ed22d7daa06a7e1b92b6f9016b'
  })

  # https://bz.apache.org/bugzilla/show_bug.cgi?id=63439
  configure_options '--with-devrandom --without-sendfile --enable-layout=GNU'
end
