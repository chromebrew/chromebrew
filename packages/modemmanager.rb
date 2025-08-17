require 'package'

class Modemmanager < Package
  description 'ModemManager is a DBus-activated daemon which controls mobile broadband (2G/3G/4G) devices and connections.'
  homepage 'https://www.freedesktop.org/wiki/Software/ModemManager/'
  version '1.24.2'
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.freedesktop.org/software/ModemManager/ModemManager-#{version}.tar.xz"
  source_sha256 '74c56b6d4ae602dab6bf290bc85a556ee2abaee1ece250e0fd1699547415c483'
  binary_compression 'tar.zst'

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
      #{CREW_CONFIGURE_OPTIONS} \
      --with-dbus-sys-dir=#{CREW_PREFIX}/share/dbus-1 \
      --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
