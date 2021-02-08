require 'package'

class Enchant < Package
  description 'Enchant is a library (and command-line program) that wraps a number of different spelling libraries and programs with a consistent interface.'
  homepage 'https://abiword.github.io/enchant/'
  @_ver = '2.2.15'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/AbiWord/enchant/archive/v#{@_ver}.tar.gz"
  source_sha256 '85295934102a4ab94f209cbc7c956affcb2834e7a5fb2101e2db436365e2922d'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/enchant-2.2.15-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/enchant-2.2.15-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/enchant-2.2.15-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/enchant-2.2.15-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '1d13b3581ec9223b127f91b29bd5838b44ed61cfee4eb6d2d58a1e3f945f0a14',
     armv7l: '1d13b3581ec9223b127f91b29bd5838b44ed61cfee4eb6d2d58a1e3f945f0a14',
       i686: 'cb657dc849d0133429a5fa8d2de803f15b098e1d05a865d538f6917c10a3234a',
     x86_64: '975d538cf6b7faf44237230c1e61c9ad51e344bded85cca9527ad4c148bccc0c'
  })

  depends_on 'aspell_en'
  depends_on 'hunspell'
  depends_on 'gnupg'

  def self.build
    system './bootstrap'
    system "env CFLAGS='-flto=auto -ltinfo' CXXFLAGS='-flto=auto' \
        LDFLAGS='-flto=auto' \
        ./configure #{CREW_OPTIONS} \
        --with-hunspell \
        --with-aspell"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
