require 'package'

class Xdg_dbus_proxy < Package
  description 'xdg-dbus-proxy is a filtering proxy for D-Bus connections.'
  homepage 'https://github.com/flatpak/xdg-dbus-proxy'
  version '0.1.2'
  compatibility 'all'
  source_url 'https://github.com/flatpak/xdg-dbus-proxy/releases/download/0.1.2/xdg-dbus-proxy-0.1.2.tar.xz'
  source_sha256 '1749d6f9f46dcc9edc87725641cf56cf91dcad1b01707891ea0850c1000c520f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xdg_dbus_proxy-0.1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xdg_dbus_proxy-0.1.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xdg_dbus_proxy-0.1.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xdg_dbus_proxy-0.1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1054fccdf3c1a8ca67a30b2daedfb6482bc346d24a8795f2016fe3d7534a1c6c',
     armv7l: '1054fccdf3c1a8ca67a30b2daedfb6482bc346d24a8795f2016fe3d7534a1c6c',
       i686: '61bbd332989ac164f86d7e33b4ea2c1686aa6b9c7e2d13ba93f44525a4b02386',
     x86_64: '966dba4f3c69eee6356687be73ad2ed27513d6e50c46b2623d05004b27ace3e4',
  })

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-maintainer-mode --disable-man"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
