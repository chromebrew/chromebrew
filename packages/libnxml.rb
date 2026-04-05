require 'buildsystems/autotools'

class Libnxml < Autotools
  description 'libnXML is a C library for parsing, writing and creating XML 1.0 and 1.1 files or streams.'
  homepage 'https://www.autistici.org/bakunin/libnxml/doc/'
  version '0.18.5-2'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://salsa.debian.org/debian/libnxml/-/archive/debian/#{version}/libnxml-debian-#{version}.tar.bz2"
  source_sha256 'bae082f80d15488415d4e24f9938a568bb6669ee54288919ab0f9dc7be59fd77'
  source_sha256 '2c3e910b591d8f2a4dde53874339ddf831cfcce4cfece429217b5a5b9f850a9d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b174cf6a1346eb736934021f24d068ab7786761dcbaac538c3ce4fc137bf998c',
     armv7l: 'b174cf6a1346eb736934021f24d068ab7786761dcbaac538c3ce4fc137bf998c',
       i686: '764abd3b20b080eab152b4d183fc59f59cf02ae50d274b28b20f1964a9da437f',
     x86_64: '2a7ba31136626e9af7015c9812218b3868c37b1ac57424b6472ef3403b9cf357'
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
