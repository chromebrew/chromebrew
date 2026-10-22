require 'buildsystems/meson'

class Bind < Meson
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/bind/'
  version '9.21.27'
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'https://gitlab.isc.org/isc-projects/bind9.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd85c1b7c476a866d11552159d4c4f94588bba293d04bc8e4df05baa061bdcb9e',
     armv7l: 'd85c1b7c476a866d11552159d4c4f94588bba293d04bc8e4df05baa061bdcb9e',
       i686: 'e11b7895c2536c946c587fefa6c5e8e4eab335c00b1f9ecdde7ca9ba4bfab708',
     x86_64: 'e5d2a0c9d5b5d79a7e69b48a9d60693b7f48f5d1a170b9a82793c881e99e0cb0'
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
