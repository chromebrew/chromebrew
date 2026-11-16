require 'buildsystems/meson'

class Pkgconf < Meson
  description 'Package compiler and linker metadata toolkit'
  homepage 'https://github.com/pkgconf/pkgconf'
  version '3.0.11'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/pkgconf/pkgconf.git'
  git_hashtag "pkgconf-#{version}"
  source_sha256 'd73ec13df8809f146a1acddec7408feaae0982d1e06afc42e3494f686ca87bfc'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'adb8a16cccbc143b6fcd5412a9db887dbe3b1000f2306aec274d13691a7c3400',
     armv7l: 'adb8a16cccbc143b6fcd5412a9db887dbe3b1000f2306aec274d13691a7c3400',
       i686: '0d56623a9a50081e5f86f6c802db836b9c062bd1de3d45ee5d13df46ecdad0df',
     x86_64: '268bd1f4abc3186c5064d1bef416331f359ab696e9544ad59ecb6b2890c571b0'
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
