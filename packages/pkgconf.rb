require 'buildsystems/meson'

class Pkgconf < Meson
  description 'Package compiler and linker metadata toolkit'
  homepage 'https://github.com/pkgconf/pkgconf'
  version '2.5.1-1'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/pkgconf/pkgconf.git'
  git_hashtag "pkgconf-#{version.split('-').first}"
  source_sha256 '6a181e0bf1195e95b7cd535a1854827aedb383b26b1fc24ca13586cb5e8e55af'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a7ca43d7d547b706cf03994e13bf2f8a10148ba5ee5f6d485222a9da7abe4b57',
     armv7l: 'a7ca43d7d547b706cf03994e13bf2f8a10148ba5ee5f6d485222a9da7abe4b57',
       i686: 'beefb30f039587728478b065e675ea6e13156d452a26cba49ab8ce91ec77ccb5',
     x86_64: '7fab7668f18dde6e0eaadf5261e392002ca8ccec61f9223e3d7fd22c1060d750'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  conflicts_ok # Conflicts with pkg_config

  # Can be enabled for packages by setting
  # ENV['PKG_CONFIG'] = "#{CREW_PREFIX}/bin/pkgconf"

  meson_options "-Dtests=disabled \
    -Dwith-system-libdir=#{CREW_LIB_PREFIX} \
    -Dwith-system-includedir=#{CREW_PREFIX}/include"

  meson_install_extras do
    File.write 'pkgconf_envd', <<~PKGCONFEOF
      export PKG_CONFIG=#{CREW_PREFIX}/bin/pkgconf
    PKGCONFEOF
    FileUtils.install 'pkgconf_envd', "#{CREW_DEST_PREFIX}/etc/env.d/pkgconf", mode: 0o644
  end
end
