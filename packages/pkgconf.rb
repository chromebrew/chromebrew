require 'buildsystems/meson'

class Pkgconf < Meson
  description 'Package compiler and linker metadata toolkit'
  homepage 'https://github.com/pkgconf/pkgconf'
  version '3.0.9'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/pkgconf/pkgconf.git'
  git_hashtag "pkgconf-#{version}"
  source_sha256 'd36c96af4866f915bfe539e82c925884dd83060153d4e1f8992166ce886a2def'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1f791f5bdfb0c995b175e3d3cd6da132678cfde59bc9270dfbd8563cd8894b57',
     armv7l: '1f791f5bdfb0c995b175e3d3cd6da132678cfde59bc9270dfbd8563cd8894b57',
       i686: '160f0739615ab5db2cbed041209e46610d9c22c9633655e519a5c0b8ac3d0fae',
     x86_64: '6053e40344979b1ea7fd40050c144fb088eefb96a92235b32d42c076319ac940'
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
