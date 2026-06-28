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
    aarch64: '8453e0b832d7df77212a9ba77d7d79a7b2d836206ea22f32a44b07f0302bc381',
     armv7l: '8453e0b832d7df77212a9ba77d7d79a7b2d836206ea22f32a44b07f0302bc381',
       i686: '686a6e5308ea63b0185e4b66a14b527d67275e3d49655b5bb8cf53e599f496fa',
     x86_64: '17c1316366dbeda1f74c613d730d1e11043b6e93058ab4cebde12c36b3cbdf4d'
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
