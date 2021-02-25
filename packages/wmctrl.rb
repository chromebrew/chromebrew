require 'package'

class Wmctrl < Package
  description 'Control your EWMH compliant window manager from command line'
  homepage 'http://tripie.sweb.cz/utils/wmctrl/'
  @_ver = '1.07'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "http://tripie.sweb.cz/utils/wmctrl/dist/wmctrl-#{@_ver}.tar.gz"
  source_sha256 'd78a1efdb62f18674298ad039c5cbdb1edb6e8e149bb3a8e3a01a4750aa3cca9'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wmctrl-1.07-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wmctrl-1.07-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wmctrl-1.07-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wmctrl-1.07-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '97f0bfc34405935c50b960f58b277560fc6cd866a8d56aedde7d963ff3e888e4',
     armv7l: '97f0bfc34405935c50b960f58b277560fc6cd866a8d56aedde7d963ff3e888e4',
       i686: '457c74eed5b513a70046d1f2c63bc8ae925c46b67df8c811ae115e7b7177a1b7',
     x86_64: '3087608f812c2888edaa264885bc1efb3044e958bdfaadc609e375b1a7172eb8'
  })

  depends_on 'libxmu'

  def self.patch
    patch_url = 'http://archive.debian.org/debian/pool/main/w/wmctrl/wmctrl_1.07-7.debian.tar.gz'
    patch_sha256 = '205c54538c9a20321af3621e00957317b3a4a3aea473b78a74e8f64632f8b958'

    system('curl', '-Lf', patch_url, '-o', 'zippatches.tar.xz')
    abort 'Checksum mismatch :/ try again'.lightred unless Digest::SHA256.hexdigest(File.read('./zippatches.tar.xz')) == patch_sha256
    system('tar', '-xf', 'zippatches.tar.xz')

    system('for i in `cat debian/patches/series`; do patch -p 1 < debian/patches/$i; done')
  end

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} make install"
  end
end
