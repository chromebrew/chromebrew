require 'package'

class Gnome_icon_theme < Package
  description 'GNOME Icon Theme'
  homepage 'https://ftp.gnome.org/pub/GNOME/sources/gnome-icon-theme/'
  version '3.12.0-1'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/gnome-icon-theme/3.12/gnome-icon-theme-3.12.0.tar.xz'
  source_sha256 '359e720b9202d3aba8d477752c4cd11eced368182281d51ffd64c8572b4e503a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_icon_theme-3.12.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_icon_theme-3.12.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_icon_theme-3.12.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_icon_theme-3.12.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd30d85fac5dd8b3bede925be24dcbae08d6935f4a258e85715c93564225028a7',
     armv7l: 'd30d85fac5dd8b3bede925be24dcbae08d6935f4a258e85715c93564225028a7',
       i686: '4f3fd419e30d860013e77040c6a77c030b8a8cca4e693ad893dab08a8e5805bf',
     x86_64: '98e7ee87dd207e81663dca35d752f92808d64cb8ebeb6a815a6ad3a8c2402e27',
  })

  depends_on 'gtk2' => :build
  depends_on 'icon_naming_utils'

  def self.build
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--enable-icon-mapping"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
