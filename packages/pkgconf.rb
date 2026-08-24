require 'buildsystems/meson'

class Pkgconf < Meson
  description 'Package compiler and linker metadata toolkit'
  homepage 'https://github.com/pkgconf/pkgconf'
  version '3.0.6'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/pkgconf/pkgconf.git'
  git_hashtag "pkgconf-#{version}"
  source_sha256 'b009ba7e3fae6cd2216191bb9417d42b5cbdf20fb55e343f9d1a21a54e65ba47'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6f44a37a68e4c4bb79b501326d57ad7db85185d155c151ef1a8a774fae2f9c54',
     armv7l: '6f44a37a68e4c4bb79b501326d57ad7db85185d155c151ef1a8a774fae2f9c54',
       i686: '4504cd56bfed10b293acebea02f60b13fd05d0baf83ac0a71b1ecae0919984a1',
     x86_64: '504aa256f8b5a80313d8fa0cc26f9b6e1a063663fc1cd490254c8c90a48a34bd'
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
