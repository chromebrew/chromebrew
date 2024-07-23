require 'package'

class Modemmanager < Package
  description 'ModemManager is a DBus-activated daemon which controls mobile broadband (2G/3G/4G) devices and connections.'
  homepage 'https://www.freedesktop.org/wiki/Software/ModemManager/'
  version '1.16.2'
  license 'GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://www.freedesktop.org/software/ModemManager/ModemManager-#{version}.tar.xz"
  source_sha256 'efa9a963499e0885f3f163096d433334143c4937545134ecd682e0157fa591e3'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '63659ccd41a81696e3ac2036d21bcb2279bd3b9aff60de09ef2fbd443712c711',
     armv7l: '63659ccd41a81696e3ac2036d21bcb2279bd3b9aff60de09ef2fbd443712c711',
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
