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
    aarch64: '4ef41dd3868f85edac7b898b7b91fb90a5ab85906709ceff2a4de706ff7b4903',
     armv7l: '4ef41dd3868f85edac7b898b7b91fb90a5ab85906709ceff2a4de706ff7b4903',
       i686: '121e239c859ac43c0c139b1763b868d68af9e471f07e8262e3a4a791c52ebc85',
     x86_64: '35ecfa1daf9e446c99d3855bc417ce39588ea186442476d8c6ba3fa7f855d580'
  })

  gnome

  def self.postinstall
    system "env FONTCONFIG_PATH=#{CREW_PREFIX}/etc/fonts fc-cache -fv || true"
  end
end
