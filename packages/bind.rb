require 'buildsystems/meson'

class Bind < Meson
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/bind/'
  version '9.21.25'
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'https://gitlab.isc.org/isc-projects/bind9.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9f9d9c6cdee3f46463154cf5fbe527b3e0e6f34192edb4aa98ceb2e29bc821c0',
     armv7l: '9f9d9c6cdee3f46463154cf5fbe527b3e0e6f34192edb4aa98ceb2e29bc821c0',
       i686: '319fa8dfd0e7567249a37f5159a82e48f74b619e4dfac071c294bfddc8b19d11',
     x86_64: 'a2b0c0a75e5ef385db03faf4ddb6dd246f8f56f6a915141f8b180eeb8fd89f0e'
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
