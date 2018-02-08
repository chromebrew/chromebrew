require 'package'

class Hicolor_icon_theme < Package
  description 'Icon-theme contains the standard also references the default icon theme called hicolor.'
  homepage 'https://www.freedesktop.org/wiki/Software/icon-theme/'
  version '0.17'
  source_url 'https://icon-theme.freedesktop.org/releases/hicolor-icon-theme-0.17.tar.xz'
  source_sha256 '317484352271d18cbbcfac3868eab798d67fff1b8402e740baa6ff41d588a9d8'


  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
