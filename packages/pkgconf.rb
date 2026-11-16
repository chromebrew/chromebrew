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
    aarch64: 'cbb76a79e426140b900aba69abde2bf7b2ca59c13a1a67c362959914fe43af58',
     armv7l: 'cbb76a79e426140b900aba69abde2bf7b2ca59c13a1a67c362959914fe43af58',
       i686: '8e37552cc635fe959fa52c018799e073fc3a956aa9f7bbba34c4d20d9a269df3',
     x86_64: '0ef6f839c4eaf99ea00c0fb7868a5cddaac157be7d63f94364608eec1e9aee23'
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
