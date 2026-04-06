require 'buildsystems/autotools'

class Libmrss < Autotools
  description 'libmRSS is a C library for parsing, writing and creating RSS files or streams.'
  homepage 'https://www.autistici.org/bakunin/libmrss/doc/'
  version '0.19.4-1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://salsa.debian.org/debian/libmrss/-/archive/debian/#{version}/libmrss-debian-#{version}.tar.bz2"
  source_sha256 '88e2f298b986fa9bcb26945d3f8df5b2ecb6e0ee11ac46bc7112b5bf28f10655'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '75c0f531737be91e830c9cdc4483bd3c01584339191dc8ccdd5fdf79302f9f76',
     armv7l: '75c0f531737be91e830c9cdc4483bd3c01584339191dc8ccdd5fdf79302f9f76',
       i686: 'c9239d7d1a2280d62240cf1fa379ab0eb1096872ddfc9a2952568bc55875b8f8',
     x86_64: '058c41757baf54b8e06d06e8d8c841be360dd03a3c3cf2464cee2b3df92f733c'
  })

  depends_on 'brotli' => :library
  depends_on 'c_ares' => :library
  depends_on 'curl' => :library
  depends_on 'glibc' => :library
  depends_on 'libcyrussasl' => :library
  depends_on 'libidn2' => :library
  depends_on 'libnghttp2' => :library
  depends_on 'libnghttp3' => :library
  depends_on 'libngtcp2' => :library
  depends_on 'libnxml' => :library
  depends_on 'libpsl' => :library
  depends_on 'libssh' => :library
  depends_on 'libunistring' => :library
  depends_on 'openldap' => :library
  depends_on 'openssl' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  def self.patch
    system "for i in \$(cat debian/patches/series); do patch -Np1 -i debian/patches/\"\${i}\"; done"
  end
end
