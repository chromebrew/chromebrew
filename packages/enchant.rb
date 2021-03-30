require 'package'

class Enchant < Package
  description 'Enchant is a library (and command-line program) that wraps a number of different spelling libraries and programs with a consistent interface.'
  homepage 'https://abiword.github.io/enchant/'
  @_ver = '2.2.15-1'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://github.com/AbiWord/enchant/archive/v#{@_ver}.tar.gz"
  source_sha256 '85295934102a4ab94f209cbc7c956affcb2834e7a5fb2101e2db436365e2922d'

  depends_on 'aspell_en'
  depends_on 'hunspell'
  depends_on 'gnupg'

  def self.build
    system './bootstrap'
    system "env CFLAGS='-flto=auto -ltinfow' CXXFLAGS='-flto=auto' \
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
