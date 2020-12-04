require 'package'

class Enchant < Package
  description 'Enchant is a library (and command-line program) that wraps a number of different spelling libraries and programs with a consistent interface.'
  homepage 'https://abiword.github.io/enchant/'
  version '2.2.13'
  compatibility 'all'
  source_url 'https://github.com/AbiWord/enchant/archive/v2.2.13.tar.gz'
  source_sha256 '783d2e847ee0a49b0552f1c5584a1c93b8ba7e93d4bd95887fc4644fb10b8563'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/enchant-2.2.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/enchant-2.2.13-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/enchant-2.2.13-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/enchant-2.2.13-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '78082be8cb3c5f1f6c37a80d1f1cfdc634db65b01f14199aeee7fe7702536a81',
     armv7l: '78082be8cb3c5f1f6c37a80d1f1cfdc634db65b01f14199aeee7fe7702536a81',
       i686: 'e3984a9b8462d07b3c811650c7fac072936172d7a695099db3162bff664698da',
     x86_64: 'eb517cf71ab7e0d54cae2027ffc59c4ece70427d2e7764fc60f45c3cb8c9b02f',
  })

  depends_on 'aspell_en'
  depends_on 'hunspell'

  def self.build
    system './bootstrap'
    system "./configure #{CREW_OPTIONS} --with-hunspell --with-aspell"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
