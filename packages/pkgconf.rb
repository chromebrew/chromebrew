require 'buildsystems/meson'

class Pkgconf < Meson
  description 'Package compiler and linker metadata toolkit'
  homepage 'https://github.com/pkgconf/pkgconf'
  version '3.0.1'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/pkgconf/pkgconf.git'
  git_hashtag "pkgconf-#{version}"
  source_sha256 'a05a0f83f5afdb8184fae5b05b4cf09b4a4f3f24942015364cede3e43c9284dd'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'de5ee3057522c1bcf1215107e7e3fa64ff74f147d7f5ff2139f118554a21f34c',
     armv7l: 'de5ee3057522c1bcf1215107e7e3fa64ff74f147d7f5ff2139f118554a21f34c',
       i686: '9f54c47b4597a82f8a55ddb98bad3a3d01159450489bf777dd80a7b23c56e933',
     x86_64: '6f4f43dc4d00b2c5441c87dcc5f55874127230647c0256506ccb5b0255913365'
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
