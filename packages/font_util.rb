require 'buildsystems/autotools'

class Font_util < Autotools
  description 'Tools for truncating and subseting of ISO10646-1 BDF fonts'
  homepage 'https://gitlab.freedesktop.org/xorg/font/util'
  version '1.4.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/font/util.git'
  git_hashtag "font-util-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1ef384a719dd423ee9529ad503f52ffa13af4afc4802a20e9e5cccac455e90c3',
     armv7l: '1ef384a719dd423ee9529ad503f52ffa13af4afc4802a20e9e5cccac455e90c3',
       i686: '50f78fd1b51145eced75ea02b93955be8c11e6fa100d47686a87481010229b4f',
     x86_64: '9e65f04191f8f2d120bff3e71368fc09b2ba41063de84eea202041a3785d72d8'
  })

  depends_on 'xorg_macros' => :build

  autotools_configure_options "--with-fontrootdir=#{CREW_PREFIX}/share/fonts"
end
