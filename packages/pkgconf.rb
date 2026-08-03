require 'buildsystems/meson'

class Pkgconf < Meson
  description 'Package compiler and linker metadata toolkit'
  homepage 'https://github.com/pkgconf/pkgconf'
  version '3.0.5'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/pkgconf/pkgconf.git'
  git_hashtag "pkgconf-#{version}"
  source_sha256 '09bd76df881c7dfe7eb7d53690c3e129a7e22f735dbb1abcc3b86ca0f77295b3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c61c83984df87d812c86e341cedf60f08ead40bde9303bd032d81a5ee4604397',
     armv7l: 'c61c83984df87d812c86e341cedf60f08ead40bde9303bd032d81a5ee4604397',
       i686: '687e1fc90f5d32685b02f3cc8582c15a9c238395a997a11c165199ae67f2fcfa',
     x86_64: '492cb887435922586d9d665f2a632284fbcd6bb9ff05e3d25704a0b5c4822450'
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
