require 'package'

class Fish < Package
  description 'fish is a smart and user-friendly command line shell for macOS, Linux, and the rest of the family.'
  homepage 'http://fishshell.com/'
  version '2.6.0'
  source_url 'https://github.com/fish-shell/fish-shell/releases/download/2.6.0/fish-2.6.0.tar.gz'
  source_sha256 '7ee5bbd671c73e5323778982109241685d58a836e52013e18ee5d9f2e638fdfb'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/fish-2.6.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/fish-2.6.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/fish-2.6.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/fish-2.6.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '45bd379b711698286d9461150c18fbf1d01446e61aa75aaf5bfcbc0dab1e1248',
     armv7l: '45bd379b711698286d9461150c18fbf1d01446e61aa75aaf5bfcbc0dab1e1248',
       i686: '173692480715219af0c366e67f182314a895dcbd816819c6a4b45a4c43da07c1',
     x86_64: '6fe888f23b24020270bbb7c30911b2ae4ffc80689c1b66612a6ba6894a50f3a8',
  })

  depends_on 'ncurses'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
