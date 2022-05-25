require 'package'

class Libdvdread < Package
  description 'libdvdnav is a library that allows easy use of sophisticated DVD navigation features such as DVD menus, multiangle playback and even interactive DVD games.'
  homepage 'http://dvdnav.mplayerhq.hu/'
  version '6.1.2'
  compatibility 'all'
  license 'GPL-2'
  source_url 'https://get.videolan.org/libdvdread/6.1.2/libdvdread-6.1.2.tar.bz2'
  source_sha256 'cc190f553758ced7571859e301f802cb4821f164d02bfacfd320c14a4e0da763'
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdvdread/6.1.2_armv7l/libdvdread-6.1.2-chromeos-armv7l.tpxz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdvdread/6.1.2_armv7l/libdvdread-6.1.2-chromeos-armv7l.tpxz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdvdread/6.1.2_i686/libdvdread-6.1.2-chromeos-i686.tpxz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdvdread/6.1.2_x86_64/libdvdread-6.1.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '594631c847c681bd2ab4753677544afa173af5299b2f4bb7e82904a547fb8b2e',
      armv7l: '594631c847c681bd2ab4753677544afa173af5299b2f4bb7e82904a547fb8b2e',
        i686: 'b59f74778057d10e26b3bb4ef7e172e512797adc76a764e9c96fcbbab76629b3',
      x86_64: 'f1819eeb9a1d5d7eff170eeaa5f832e6e02e2c0153a333fc88f20088bbb3402e'
  })

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
