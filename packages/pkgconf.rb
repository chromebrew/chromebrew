require 'buildsystems/meson'

class Pkgconf < Meson
  description 'Package compiler and linker metadata toolkit'
  homepage 'https://github.com/pkgconf/pkgconf'
  version '3.0.4'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/pkgconf/pkgconf.git'
  git_hashtag "pkgconf-#{version}"
  source_sha256 '6ea75f53353f69b2a12845615996f75957bb3005350c785a419954e076dbdd2a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '72fea5797dd5ed693ab0ef7715778106f4a7b69c56bd49e7924ebc6197f2ecef',
     armv7l: '72fea5797dd5ed693ab0ef7715778106f4a7b69c56bd49e7924ebc6197f2ecef',
       i686: 'd49a0570a4f616986c3991a2fec20647e2ec1543c0036ee039b03423bc2ca8df',
     x86_64: '12db96f0af7fafd144da722b34c1a309447ee3fcf2b9ad96b5d7c187cc60992a'
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
