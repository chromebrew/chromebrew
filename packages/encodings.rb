require 'buildsystems/autotools'

class Encodings < Autotools
  description 'X11 Font Index Generator'
  homepage 'https://xorg.freedesktop.org/wiki/'
  version '1.1.0'
  license 'custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/font/encodings.git'
  git_hashtag "encodings-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ef6928a60a5750579fdb73aeb19f7fda8dc5482b3971d0e9eb4d2c8ced917028',
     armv7l: 'ef6928a60a5750579fdb73aeb19f7fda8dc5482b3971d0e9eb4d2c8ced917028',
     x86_64: '4afda61a6d7ea03e7df01078f7aa7c40e00d0865328ac77be45e9123f3d7b095'
  })

  depends_on 'font_util' => :executable
  depends_on 'mkfontscale' => :executable

  autotools_configure_options "--with-fontrootdir=#{CREW_PREFIX}/share/fonts"

  autotools_pre_make_options do
    system "sed -e 's|^\(encodings_DATA = $(DATA_FILES)\).*|\1|' -i Makefile" # Found in xbps-src
  end
end
