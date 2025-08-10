# Adapted from Arch Linux adwaita-fonts PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/adwaita-fonts/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/meson'

class Adwaita_fonts < Meson
  description 'The typefaces for GNOME'
  homepage 'https://gitlab.gnome.org/GNOME/adwaita-fonts'
  version '49.0'
  license 'GPL-3.0-or-later'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/adwaita-fonts.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '160717021efacb26bc3081b8bea9340f3d60cafa0177d5bbe3885c08b2510229',
     armv7l: '160717021efacb26bc3081b8bea9340f3d60cafa0177d5bbe3885c08b2510229',
       i686: 'e6bb45b765227feb876cd9d7ab32618e5b900da3d06b4c0820aa06f7ceea164e',
     x86_64: '777bebbea612e54df97b1d2f055a8f10dfb6189867658163895b6f214e1dd92e'
  })

  gnome

  def self.postinstall
    system "env FONTCONFIG_PATH=#{CREW_PREFIX}/etc/fonts fc-cache -fv || true"
  end
end
