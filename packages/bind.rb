require 'buildsystems/meson'

class Bind < Meson
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/bind/'
  version '9.21.24'
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'https://gitlab.isc.org/isc-projects/bind9.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '221f3bd9daf7ba5b6a6bf04b0b26f7dc9feb572e27ba87b87fd6b67420764ef1',
     armv7l: '221f3bd9daf7ba5b6a6bf04b0b26f7dc9feb572e27ba87b87fd6b67420764ef1',
       i686: '918347b8281d99c8a87494727c32051b79ce259a65ccf85d46cd6411446217ae',
     x86_64: 'f5cd5ae5df7d0eeb5bda55409e4d803f8f351f70cec103b83c5db97a0d749c0a'
  })

  depends_on 'e2fsprogs' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'jemalloc' => :library
  depends_on 'json_c' => :library
  depends_on 'krb5' => :library
  depends_on 'libcap' => :executable
  depends_on 'libedit' => :executable
  depends_on 'libidn2' => :executable
  depends_on 'libnghttp2' => :library
  depends_on 'libunistring' => :build
  depends_on 'liburcu' => :library
  depends_on 'libuv' => :library
  depends_on 'libxml2' => :library
  depends_on 'lmdb' => :library
  depends_on 'ncurses' => :build
  depends_on 'openssl' => :library
  depends_on 'py3_ply' => :build
  depends_on 'sphinx' => :build
  depends_on 'zlib' => :library

  meson_options '-Dnamed-lto=disabled'
end
