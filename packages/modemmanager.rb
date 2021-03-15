require 'package'

class Modemmanager < Package
  description 'ModemManager is a DBus-activated daemon which controls mobile broadband (2G/3G/4G) devices and connections.'
  homepage 'https://www.freedesktop.org/wiki/Software/ModemManager/'
  @_ver = '1.16.2'
  version @_ver
  compatibility 'all'
  source_url "https://www.freedesktop.org/software/ModemManager/ModemManager-#{@_ver}.tar.xz"
  source_sha256 'efa9a963499e0885f3f163096d433334143c4937545134ecd682e0157fa591e3'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/modemmanager-1.16.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/modemmanager-1.16.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/modemmanager-1.16.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/modemmanager-1.16.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '63659ccd41a81696e3ac2036d21bcb2279bd3b9aff60de09ef2fbd443712c711',
     armv7l: '63659ccd41a81696e3ac2036d21bcb2279bd3b9aff60de09ef2fbd443712c711',
       i686: 'be289c76c0103c0a66017f52dbb5c61bcee619f1fca8f160195adfb8d4d8b07f',
     x86_64: '290c162bd314ba5d52cdc5f3a9d8abe1efc78349214392c237885653cfdf76a2'
  })

  depends_on 'libmbim'
  depends_on 'libqmi'

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS} \
      --with-dbus-sys-dir=#{CREW_PREFIX}/share/dbus-1 \
      --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
