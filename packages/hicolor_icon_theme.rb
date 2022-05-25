require 'package'

class Hicolor_icon_theme < Package
  description 'Icon-theme contains the standard also references the default icon theme called hicolor.'
  homepage 'https://www.freedesktop.org/wiki/Software/icon-theme/'
  version '0.17'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://icon-theme.freedesktop.org/releases/hicolor-icon-theme-0.17.tar.xz'
  source_sha256 '317484352271d18cbbcfac3868eab798d67fff1b8402e740baa6ff41d588a9d8'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/hicolor_icon_theme/0.17_armv7l/hicolor_icon_theme-0.17-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/hicolor_icon_theme/0.17_armv7l/hicolor_icon_theme-0.17-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/hicolor_icon_theme/0.17_i686/hicolor_icon_theme-0.17-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/hicolor_icon_theme/0.17_x86_64/hicolor_icon_theme-0.17-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '3341e27bb5e2ea8c55b573c32bf34ba4e88da50c6cc1d865eb1c2d91232d44e6',
     armv7l: '3341e27bb5e2ea8c55b573c32bf34ba4e88da50c6cc1d865eb1c2d91232d44e6',
       i686: '574db604ef7db3b401e56ce4387e2a488952fcfa308316cc7127f872ee87557c',
     x86_64: 'f0640114582b89e78c5e884e801d512b3a0f484443fdc0157a6f4db289261bae'
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
