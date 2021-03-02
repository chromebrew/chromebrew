require 'package'

class Libqmi < Package
  description 'libqmi is a glib-based library for talking to WWAN modems and devices which speak the Qualcomm MSM Interface (QMI) protocol.'
  homepage 'https://www.freedesktop.org/wiki/Software/libqmi/'
  @_ver = '1.28.2'
  version @_ver
  compatibility 'all'
  source_url "https://www.freedesktop.org/software/libqmi/libqmi-#{@_ver}.tar.xz"
  source_sha256 '8c8c3ee719874d2529bce9b35b028fe435b36f003979a360d3ad0938449db783'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libqmi-1.28.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libqmi-1.28.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libqmi-1.28.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libqmi-1.28.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '03ccdba7bf32be2b5e02951d25a664af9654acceb1eb5c71fcbf5179a46190d7',
     armv7l: '03ccdba7bf32be2b5e02951d25a664af9654acceb1eb5c71fcbf5179a46190d7',
       i686: '4c313be829849b7d22d803b25d165d4247d89d38451e9ec9d21bb624d52665cd',
     x86_64: '49c2629596059768498962291481e1d0212bdb2e56b5bdf37f834aeb84fe8680'
  })

  depends_on 'libgudev'

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS} \
      --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
