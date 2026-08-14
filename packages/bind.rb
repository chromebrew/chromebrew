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
    aarch64: 'c9a55ad5ba3ac70bb731435d6edf365407d910ad0c89955b89cc98f424398069',
     armv7l: 'c9a55ad5ba3ac70bb731435d6edf365407d910ad0c89955b89cc98f424398069',
       i686: '30fa074f574bc4e8bf2813481325c9f1f6b7a79ea181c7da485c0c787db1953f',
     x86_64: '2e5c001a88419a8034be43f57b46ab31352a26019b1bfe2f4817c10f8ffafa44'
  })

  depends_on 'e2fsprogs' # R
  depends_on 'glibc' => :library
  depends_on 'jemalloc' => :library
  depends_on 'json_c' => :library
  depends_on 'krb5' => :library
  depends_on 'libcap' => :executable
  depends_on 'libedit' => :executable
  depends_on 'libidn2' => :executable
  depends_on 'libnghttp2' => :library
  depends_on 'libunistring' # R
  depends_on 'liburcu' => :library
  depends_on 'libuv' => :library
  depends_on 'libxml2' => :library
  depends_on 'lmdb' => :library
  depends_on 'ncurses' # R
  depends_on 'openssl' => :library
  depends_on 'py3_ply' => :build
  depends_on 'sphinx' => :build
  depends_on 'zlib' => :library

  meson_options '-Dnamed-lto=disabled'
end
