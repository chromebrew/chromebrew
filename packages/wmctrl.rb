require 'package'

class Wmctrl < Package
  description 'Control your EWMH compliant window manager from command line'
  homepage 'http://tripie.sweb.cz/utils/wmctrl/'
  @_ver '1.07'
  version @_ver
  compatibility 'all'
  source_url "http://tripie.sweb.cz/utils/wmctrl/dist/wmctrl-#{@_ver}.tar.gz"
  source_sha256 'd78a1efdb62f18674298ad039c5cbdb1edb6e8e149bb3a8e3a01a4750aa3cca9'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wmctrl-1.07-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wmctrl-1.07-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wmctrl-1.07-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wmctrl-1.07-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '1119d1b966ce30181f6ae4bf8ccd5d5f50d44fb7cf4de26444dc135347239358',
     armv7l: '1119d1b966ce30181f6ae4bf8ccd5d5f50d44fb7cf4de26444dc135347239358',
       i686: '23f14ca9583c1ae9d4fa8de2654fb452ee72f980866eb42aa3e8a45794426f9a',
     x86_64: 'a501256720922d44fba60583c79d71f88201fbf563f538ed087475a00169ab1b'
  })

  depends_on 'libxmu'

  def self.patch
    # Debian patch
    patch_url = 'http://archive.debian.org/debian/pool/main/w/wmctrl/wmctrl_1.07-6.diff.gz'
    patch_sha256 = 'c6560ba645652eab0b16d46c9dbd8e5c9881c1f9d3ac6fa3da2ee3c865b5e6a0'

    system('wget', '--continue', '--no-check-certificate', patch_url, '-O', 'patch.gz')
    abort 'Checksum mismatch :/ try again' unless Digest::SHA256.hexdigest(File.read('./patch.gz')) == patch_sha256
    system('gunzip', 'patch.gz')
    system 'patch -p 1 < patch'
  end

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} make install"
  end
end
