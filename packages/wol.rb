require 'package'

class Wol < Package
  description 'Wake up hardware that is Magic Packet compliant'
  homepage 'http://ahh.sourceforge.net/wol/'
  version '0.7.1'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/ahh/wol-0.7.1.tar.gz'
  source_sha256 'e0086c9b9811df2bdf763ec9016dfb1bcb7dba9fa6d7858725b0929069a12622'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wol-0.7.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wol-0.7.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wol-0.7.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wol-0.7.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '83abf28069852e88d080740c682be692007134532e9f045173cf10def41bc26d',
     armv7l: '83abf28069852e88d080740c682be692007134532e9f045173cf10def41bc26d',
       i686: 'e0c1b4a267d50208fa0e1979effbb425fa14aeffe1a49029e0f45967cedc3e7f',
     x86_64: '27cf6ed4e02b068ffc59b650d165b575a921403c64fe74be8875860c96357c13',
  })

  def self.build
    system './configure', "--prefix=#{CREW_PREFIX}", "--mandir=#{CREW_MAN_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "MANDIR=#{CREW_DEST_MAN_PREFIX}/man1", 'install'
  end
end
