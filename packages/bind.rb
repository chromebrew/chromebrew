require 'buildsystems/meson'

class Bind < Meson
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/bind/'
  version '9.21.28'
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'https://gitlab.isc.org/isc-projects/bind9.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f10f59ced2e45ec28d3b7facacd59e23a75157aa8ea78db860b77b7f711bf14e',
     armv7l: 'f10f59ced2e45ec28d3b7facacd59e23a75157aa8ea78db860b77b7f711bf14e',
       i686: '07e0b0e3f35acb22559be65185dd1335081807f6d6e4ef2578f355c034683d56',
     x86_64: 'efc01b918ca9007d0c63673cc1e1519e0d968aaffe8a9bda9ea7716f470af977'
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
