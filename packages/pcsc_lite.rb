require 'package'

class Pcsc_lite < Package
  description 'PCSC is middleware to access a smart card using SCard API (PC/SC).'
  homepage 'https://pcsclite.apdu.fr/'
  version '1.9.5'
  compatibility 'x86_64 aarch64 armv7l'
  license 'BSD, ISC, MIT, GPL-3+ and GPL-2'
  source_url 'https://salsa.debian.org/debian/pcsc-lite.git'
  git_hashtag "debian/#{version}-1"
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '7b33707baf6fbbebbd4cdbf53d0f4ced3db4175101ae48794d229e946a37d355',
      armv7l: '7b33707baf6fbbebbd4cdbf53d0f4ced3db4175101ae48794d229e946a37d355',
      x86_64: '356190c9a9118bb46981627a2d132d8209a035fe5003000584789e41f305e796'
  })

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
