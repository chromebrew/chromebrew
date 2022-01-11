require 'package'

class Pcsc_lite < Package
  description 'PCSC is middleware to access a smart card using SCard API (PC/SC).'
  homepage 'https://pcsclite.apdu.fr/'
  @_ver = '1.9.5'
  version @_ver
  license 'BSD, ISC, MIT, GPL-3+ and GPL-2'
  compatibility 'all'
  source_url 'https://salsa.debian.org/debian/pcsc-lite.git'
  git_hashtag 'debian/' + @_ver + '-1'

  depends_on 'eudev'
  depends_on 'libusb'
  depends_on 'polkit'
  depends_on 'elogind'

  def self.patch
    system "for i in \$(cat debian/patches/series); do patch -Np1 -i debian/patches/\${i}; done"
  end

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
              --disable-libsystemd"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
