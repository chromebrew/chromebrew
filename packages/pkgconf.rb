require 'buildsystems/meson'

class Pkgconf < Meson
  description 'Package compiler and linker metadata toolkit'
  homepage 'https://github.com/pkgconf/pkgconf'
  version '2.9.90'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/pkgconf/pkgconf.git'
  git_hashtag "pkgconf-#{version}"
  source_sha256 'dcc3ff791054c7f856be123e6ebc6b04267a8d4470176f3a937a71f31c272218'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a10f2d2cd22526665ed97c46afe7b4122d223969f7378594f06ce532c26ea269',
     armv7l: 'a10f2d2cd22526665ed97c46afe7b4122d223969f7378594f06ce532c26ea269',
       i686: '1ee679cd1159a2e7ff6b02fb1445751be8cbb11068a75b0cb745fdae53f5eba6',
     x86_64: '6f6bc458f2643c0b56d69a2e97e0c0e880cf12eb22f5cb61785bb8f9f735e6d2'
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
