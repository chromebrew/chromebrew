require 'buildsystems/meson'

class Cantarell_fonts < Meson
  description 'Humanist sans serif font'
  homepage 'https://cantarell.gnome.org/'
  version '0.311'
  license 'OFL-1.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://cantarell.gnome.org/releases/cantarell-fonts-#{version}.tar.xz"
  source_sha256 'f9463a0659c63e57e381fdd753cf1929225395c5b49135989424761830530411'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9d37e650e39b1e9cf718ea60d37385331d2a00010a63afcc8ff3abd38347f9a3',
     armv7l: '9d37e650e39b1e9cf718ea60d37385331d2a00010a63afcc8ff3abd38347f9a3',
     x86_64: 'c83f1a21fcc935eefdec1c1cc8e0ce2ccb12e1f7389e1790c2adba44943f777e'
  })

  depends_on 'appstream_glib' => :build
  depends_on 'fontconfig' => :build
  depends_on 'graphite' => :build

  gnome

  meson_options "-Duseprebuilt=true \
    -Dfontsdir=#{CREW_PREFIX}/share/fonts/opentype/cantarell"

  meson_install_extras do
    FileUtils.mkdir_p "#{CREW_PREFIX}/share/fonts/opentype/cantarell"
  end

  def self.postinstall
    system "env FONTCONFIG_PATH=#{CREW_PREFIX}/etc/fonts fc-cache -fv || true"
  end
end
