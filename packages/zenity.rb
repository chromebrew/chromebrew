require 'package'

class Zenity < Package
  description 'A tool that allows you to display GTK dialog boxes in commandline and shell scripts.'
  homepage 'https://wiki.gnome.org/Projects/Zenity'
  version '3.32.0'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://deb.debian.org/debian/pool/main/z/zenity/zenity_3.32.0.orig.tar.xz'
  source_sha256 'e786e733569c97372c3ef1776e71be7e7599ebe87e11e8ad67dcc2e63a82cd95'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'ad62a47795d7d1c530f9237dd64d33e773d347723d808dee489636652612b944',
     armv7l: 'ad62a47795d7d1c530f9237dd64d33e773d347723d808dee489636652612b944',
     x86_64: '4903f1cc1859b0df09348dcf920b6f8eae84e66151f4463e23ccd4a07b73d3c9'
  })

  depends_on 'gtk3'
  depends_on 'webkit2gtk'

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
