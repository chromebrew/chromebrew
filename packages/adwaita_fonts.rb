# Adapted from Arch Linux adwaita-fonts PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/adwaita-fonts/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/meson'

class Adwaita_fonts < Meson
  description 'The typefaces for GNOME'
  homepage 'https://gitlab.gnome.org/GNOME/adwaita-fonts'
  version '51.0'
  license 'GPL-3.0-or-later'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/adwaita-fonts.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '98853d0b889ed2da92bed888c86ece4934fa34feff689819236bb2d6de29d0f4',
     armv7l: '98853d0b889ed2da92bed888c86ece4934fa34feff689819236bb2d6de29d0f4',
       i686: '0558262577ae7cd160e3ec7c352a483e2d9cbacd865843f97f8fd43bb8a9c20e',
     x86_64: 'cb53fcbc99dda1977c8ad64729a0322dba5a40dacd9cc18b503d9f17e0b54097'
  })

  gnome

  def self.postinstall
    system "env FONTCONFIG_PATH=#{CREW_PREFIX}/etc/fonts fc-cache -fv || true"
  end
end
