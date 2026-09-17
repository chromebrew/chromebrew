require 'buildsystems/meson'

class Bind < Meson
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/bind/'
  version '9.21.26'
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'https://gitlab.isc.org/isc-projects/bind9.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3270ebfb7dee7448c0865553e6c944f0d3edf9d22be550969440e5ae8d11faf7',
     armv7l: '3270ebfb7dee7448c0865553e6c944f0d3edf9d22be550969440e5ae8d11faf7',
       i686: 'c774cc0dabec1b32d56d5a85bc9b2073423efec5cf45a9395149a95afc41587e',
     x86_64: '8cc9c379551e23eff51834a46565e84afe0715b49bd1aae14e6db06f2013b9f8'
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
