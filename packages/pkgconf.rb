require 'buildsystems/meson'

class Pkgconf < Meson
  description 'Package compiler and linker metadata toolkit'
  homepage 'https://github.com/pkgconf/pkgconf'
  version '2.1.1'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/pkgconf/pkgconf/archive/pkgconf-2.1.1.tar.gz'
  source_sha256 '6a181e0bf1195e95b7cd535a1854827aedb383b26b1fc24ca13586cb5e8e55af'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'df02dc6ab12c3df61808e5274f76fd958452a7d315d6200052feee8a587a962b',
     armv7l: 'df02dc6ab12c3df61808e5274f76fd958452a7d315d6200052feee8a587a962b',
       i686: '3496062a996fc18ce28b7ed237cae1b2732f9150d1acf187cf05293267a355ea',
     x86_64: '27e9ebcfbbd391280ee650c45d19dfde2a5e0771bcc455214a1111869231c865'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  # Can be enabled for packages by setting
  # ENV['PKG_CONFIG'] = "#{CREW_PREFIX}/bin/pkgconf"

  meson_options "-Dtests=disabled \
    -Dwith-system-libdir=#{CREW_LIB_PREFIX} \
    -Dwith-system-includedir=#{CREW_PREFIX}/include"
end
