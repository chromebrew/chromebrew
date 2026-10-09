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
    aarch64: '9068271bacc267db480da07be9439c5057c5045ce29dea10957d7cf8888e0f22',
     armv7l: '9068271bacc267db480da07be9439c5057c5045ce29dea10957d7cf8888e0f22',
       i686: '7e574c631515320836fd179133a1034682664c1b455599bfa5213f7c61b49062',
     x86_64: '672c458fec8541c42ce163179714e2cd2a02ce80b5a26f5182c05ccbbc28a8f1'
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
