require 'buildsystems/autotools'

class Libstrophe < Autotools
  description 'A simple, lightweight C library for writing XMPP clients'
  homepage 'http://strophe.im/libstrophe/'
  version '0.14.0'
  license 'MIT or GPL-3'
  compatibility 'all'
  source_url 'https://github.com/strophe/libstrophe.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd1d0a6759ef350ec42cace34fc043729748c21b94cfd28ab594670ddee09bd20',
     armv7l: 'd1d0a6759ef350ec42cace34fc043729748c21b94cfd28ab594670ddee09bd20',
       i686: 'c67536f33ab7c711ee8327917266aad7d47cc7c790de7392c6590d0dc15d1aa6',
     x86_64: '588d59c166d70f4a8b2692e5d44b34d35cd01b8573093d8a72dd718e3ec33079'
  })

  depends_on 'expat' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libxml2' => :library
  depends_on 'openssl' => :library
  depends_on 'zlib' => :library

  # Fix error: passing argument 3 of '_timed_handler_add' from incompatible pointer type [-Wincompatible-pointer-types]
  autotools_configure_options "CFLAGS='-Wno-incompatible-pointer-types'"
end
