require 'package'

class Hunspell < Package
  description 'Hunspell is a spell checker and morphological analyzer library'
  homepage 'http://hunspell.github.io/'
  version '1.6.2'
  source_url 'https://github.com/hunspell/hunspell/archive/v1.6.2.tar.gz'
  source_sha256 '3cd9ceb062fe5814f668e4f22b2fa6e3ba0b339b921739541ce180cac4d6f4c4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/hunspell-1.6.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/hunspell-1.6.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/hunspell-1.6.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/hunspell-1.6.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2122527ab9f428c6d88d22ea142c134bf648b933963178f368ce5e9832d93317',
     armv7l: '2122527ab9f428c6d88d22ea142c134bf648b933963178f368ce5e9832d93317',
       i686: '1e7bd3254580e4a211b1b8208e548675602290e9c7a1105ba66af6d4c9cee8da',
     x86_64: '76e93eec7e0cec41707fd68f0f21351e94c25e8b993431f3bf400693d3de8251',
  })

  depends_on 'readline'

  def self.build
    system 'autoreconf -vfi'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--with-readline',
           '--with-ui'
    system "sed -i 's,/usr/share,#{CREW_PREFIX}/share,g' man/hunspell.1"
    system "sed -i 's,/usr/share,#{CREW_PREFIX}/share,g' src/tools/hunspell.cxx"
    system "sed -i 's,ncurses.h,#{CREW_PREFIX}/include/ncursesw/ncurses.h,' src/tools/hunspell.cxx"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system 'git clone -b libreoffice-6-1 --depth 1 git://anongit.freedesktop.org/libreoffice/dictionaries.git'
    system "install -Dm644 dictionaries/en/en_US.aff #{CREW_DEST_DIR}$HOME/Library/Spelling/en_US.aff"
    system "install -Dm644 dictionaries/en/en_US.dic #{CREW_DEST_DIR}$HOME/Library/Spelling/en_US.dic"
    system "install -Dm644 dictionaries/en/en_US.aff $HOME/Library/Spelling/en_US.aff"
    system "install -Dm644 dictionaries/en/en_US.dic $HOME/Library/Spelling/en_US.dic"
  end

  def self.postinstall
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "echo 'export DICTIONARY=en_US' >> ~/.bashrc && source ~/.bashrc".lightblue
    puts
  end
end
