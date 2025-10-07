require 'buildsystems/meson'

class Pkgconf < Meson
  description 'Package compiler and linker metadata toolkit'
  homepage 'https://github.com/pkgconf/pkgconf'
  version '2.5.1-2'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/pkgconf/pkgconf.git'
  git_hashtag "pkgconf-#{version.split('-').first}"
  source_sha256 '6a181e0bf1195e95b7cd535a1854827aedb383b26b1fc24ca13586cb5e8e55af'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd825a4bdf4288352534124efe0f81aae52ed6904874e856cd5205d6cfae5907d',
     armv7l: 'd825a4bdf4288352534124efe0f81aae52ed6904874e856cd5205d6cfae5907d',
       i686: 'b2563afcd3e4fc0d19d9facafaae4af075e7de7b391e8e64d0f02b18d1cf4b1a',
     x86_64: 'aeac2450e6fc88c3aca358df15e062d3606dc28389c45fbe34f77c7ecfff43c9'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  conflicts_ok # Conflicts with pkg_config

  meson_options "-Dtests=disabled \
    -Dwith-system-libdir=#{CREW_LIB_PREFIX} \
    -Dwith-system-includedir=#{CREW_PREFIX}/include"

  meson_install_extras do
    File.write 'pkgconf_envd', <<~PKGCONFEOF
      export PKG_CONFIG=#{CREW_PREFIX}/bin/pkgconf
    PKGCONFEOF
    FileUtils.install 'pkgconf_envd', "#{CREW_DEST_PREFIX}/etc/env.d/pkgconf", mode: 0o644
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/pkgconf", "#{CREW_DEST_PREFIX}/bin/pkg-config"
  end
end
