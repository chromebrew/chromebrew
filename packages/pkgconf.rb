require 'buildsystems/meson'

class Pkgconf < Meson
  description 'Package compiler and linker metadata toolkit'
  homepage 'https://github.com/pkgconf/pkgconf'
  version '3.0.0'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/pkgconf/pkgconf.git'
  git_hashtag "pkgconf-#{version}"
  source_sha256 'f018b9867b2c38683cf51f83607d3c2d90cf2e52d6ab3bd71ee46dcfb91446db'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9e0cc9374f0a97a29e602e3b6f9041050776b62ffb4bd6865c46847a29603677',
     armv7l: '9e0cc9374f0a97a29e602e3b6f9041050776b62ffb4bd6865c46847a29603677',
       i686: 'f7bfd52b3dc84d6119431cbe5021fd20ad24e4e9ea361cc11a2b73aa783de3e0',
     x86_64: 'e8b6086e270c22b5da28d452de0fe31b862574f0bc249d8f0650dbab691d452e'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  conflicts_ok # Conflicts with pkg_config

  meson_options "-Dwith-system-libdir=#{CREW_LIB_PREFIX} \
    -Dwith-system-includedir=#{CREW_PREFIX}/include"

  meson_install_extras do
    File.write 'pkgconf_envd', <<~PKGCONFEOF
      export PKG_CONFIG=#{CREW_PREFIX}/bin/pkgconf
    PKGCONFEOF
    FileUtils.install 'pkgconf_envd', "#{CREW_DEST_PREFIX}/etc/env.d/pkgconf", mode: 0o644
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/pkgconf", "#{CREW_DEST_PREFIX}/bin/pkg-config"
  end
end
