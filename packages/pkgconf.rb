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
    aarch64: 'e70792569df03e8346340762d5efc5498e0a7501d0215144d683d33e07b15a9f',
     armv7l: 'e70792569df03e8346340762d5efc5498e0a7501d0215144d683d33e07b15a9f',
       i686: 'cdc174a5e3a7bed4d756747d4e6b0af11eff9edc605cda53699966cbce915f5a',
     x86_64: '6c3259626266d6610168716eae04a5372403b85905a91ea1733e397f381d6899'
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
