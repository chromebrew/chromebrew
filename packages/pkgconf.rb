require 'buildsystems/meson'

class Pkgconf < Meson
  description 'Package compiler and linker metadata toolkit'
  homepage 'https://github.com/pkgconf/pkgconf'
  version '3.0.8'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/pkgconf/pkgconf.git'
  git_hashtag "pkgconf-#{version}"
  source_sha256 'b7541fcecb4cc568b181534a1470d6e40027029f148be73eaf4c7d29beb1cc36'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '335544f9dff1c5d8bb582af577899bcd02185cfd75e079c280008d5906ddcb69',
     armv7l: '335544f9dff1c5d8bb582af577899bcd02185cfd75e079c280008d5906ddcb69',
       i686: '9b9c60b01501d2f4d8e3db171d68d8f4473daf462e017653d269e70476097de7',
     x86_64: '90def85ecb2aa1a4689e6d4112742baf1859a185d2200d589da855192972073f'
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
