require 'buildsystems/meson'

class Pkgconf < Meson
  description 'Package compiler and linker metadata toolkit'
  homepage 'https://github.com/pkgconf/pkgconf'
  version '2.9.94'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/pkgconf/pkgconf.git'
  git_hashtag "pkgconf-#{version}"
  source_sha256 'bf9fd1886c5cf42883ad7f7a0cb76ceaffd15424df7216ecefb553dea45395cc'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3233e24b64e850deb334bf0b702dac0be6b11901ba123ccbe651dd3b47b2adb9',
     armv7l: '3233e24b64e850deb334bf0b702dac0be6b11901ba123ccbe651dd3b47b2adb9',
       i686: '3704e222aed7796ebdf658f5901ddedfae446b61bc285a626306dfeb945429a7',
     x86_64: 'abd654df1ffe4a5c592891c2fb962334267430082c2548d8ab4e8af6259a831b'
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
