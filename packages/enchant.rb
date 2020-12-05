require 'package'

class Enchant < Package
  description 'Enchant is a library (and command-line program) that wraps a number of different spelling libraries and programs with a consistent interface.'
  homepage 'https://abiword.github.io/enchant/'
  version '2.2.13'
  compatibility 'all'
  source_url 'https://github.com/AbiWord/enchant/archive/v2.2.13.tar.gz'
  source_sha256 '783d2e847ee0a49b0552f1c5584a1c93b8ba7e93d4bd95887fc4644fb10b8563'


  depends_on 'aspell_en'
  depends_on 'hunspell'
  depends_on 'gnupg'

  def self.build
    system "./bootstrap" 
    system "./configure #{CREW_OPTIONS} --with-hunspell --with-aspell"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
