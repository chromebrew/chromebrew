require 'buildsystems/meson'

class Pkgconf < Meson
  description 'Package compiler and linker metadata toolkit'
  homepage 'https://github.com/pkgconf/pkgconf'
  version '2.5.1'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/pkgconf/pkgconf.git'
  git_hashtag "pkgconf-#{version}"
  source_sha256 '6a181e0bf1195e95b7cd535a1854827aedb383b26b1fc24ca13586cb5e8e55af'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8717887d196af6b2970b542d59196625997af8d0c13732ca3a5dbb6ed2684f42',
     armv7l: '8717887d196af6b2970b542d59196625997af8d0c13732ca3a5dbb6ed2684f42',
       i686: 'dabeea4374873f88ec064d40375584d7d311039ed167dc1b221b7e0c53e44a54',
     x86_64: 'ae962bd24c03bdebde15e8a2fefb185ab6e0b0e5ab5f76c59d092e6d1beee721'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  conflicts_ok # Conflicts with pkg_config

  # Can be enabled for packages by setting
  # ENV['PKG_CONFIG'] = "#{CREW_PREFIX}/bin/pkgconf"

  meson_options "-Dtests=disabled \
    -Dwith-system-libdir=#{CREW_LIB_PREFIX} \
    -Dwith-system-includedir=#{CREW_PREFIX}/include"
end
