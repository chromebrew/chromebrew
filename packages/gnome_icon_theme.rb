require 'package'

class Gnome_icon_theme < Package
  description 'GNOME Icon Theme'
  homepage 'https://ftp.gnome.org/pub/GNOME/sources/gnome-icon-theme/'
  version '3.12.0'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/gnome-icon-theme/3.12/gnome-icon-theme-3.12.0.tar.xz'
  source_sha256 '359e720b9202d3aba8d477752c4cd11eced368182281d51ffd64c8572b4e503a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_icon_theme-3.12.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_icon_theme-3.12.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_icon_theme-3.12.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_icon_theme-3.12.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '69df3dead88dd49730c8ba282b473a2052ec910a4fb8259f132066d6d55d9c67',
     armv7l: '69df3dead88dd49730c8ba282b473a2052ec910a4fb8259f132066d6d55d9c67',
       i686: '0ab623d3e86efa317be11c0774e5c42486796a94be09b49110aaed207e91045e',
     x86_64: '43f0676b7b5a59eab61f54b3e4213f27e7397c591c77d738349f1cb971886ffd',
  })

  depends_on 'gtk3'
  depends_on 'icon_naming_utils'

  def self.patch
    # Fixes error when building .po files
    system "sed -i 's,SUBDIRS = po,SUBDIRS =,' Makefile.in"
  end

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
