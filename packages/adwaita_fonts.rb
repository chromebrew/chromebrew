# Adapted from Arch Linux adwaita-fonts PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/adwaita-fonts/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/meson'

class Adwaita_fonts < Meson
  description 'The typefaces for GNOME'
  homepage 'https://gitlab.gnome.org/GNOME/adwaita-fonts'
  version '50.0'
  license 'GPL-3.0-or-later'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/adwaita-fonts.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5cfa686675791adb6766b2db51682c9b332797bd26ee6840ebcec28505a244e9',
     armv7l: '5cfa686675791adb6766b2db51682c9b332797bd26ee6840ebcec28505a244e9',
       i686: '8b5abc70d5301f5240f7ed2d3427998335430e1e193ed20e3ddf1a54d205ab7d',
     x86_64: 'e55f151952f36e7b31dfb0071417874f0987284f828878ff1b36240a96bf3b3e'
  })

  gnome

  def self.postinstall
    system "env FONTCONFIG_PATH=#{CREW_PREFIX}/etc/fonts fc-cache -fv || true"
  end
end
