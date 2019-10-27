require 'package'

class Hunspell < Package
  description 'Hunspell is a spell checker and morphological analyzer library'
  homepage 'http://hunspell.github.io/'
  version '1.7.0'
  source_url 'https://github.com/hunspell/hunspell/archive/v1.7.0.tar.gz'
  source_sha256 'bb27b86eb910a8285407cf3ca33b62643a02798cf2eef468c0a74f6c3ee6bc8a'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'readline'
  depends_on 'ncurses'

  def self.build
    system 'autoreconf -vfi'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--include=#{CREW_PREFIX}/include",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--with-ui',
           '--with-readline'
    system "sed -i 's,/usr/share,#{CREW_PREFIX}/share,g' man/hunspell.1"
    system "sed -i 's,/usr/share,#{CREW_PREFIX}/share,g' src/tools/hunspell.cxx"
    system "sed -i 's,ncurses.h,#{CREW_PREFIX}/include/ncursesw/ncurses.h,' src/tools/hunspell.cxx"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.postinstall
    system 'git clone -b libreoffice-6-1 --depth 1 git://anongit.freedesktop.org/libreoffice/dictionaries.git'
    system "install -Dm644 dictionaries/en/en_US.aff #{CREW_DEST_DIR}$HOME/Library/Spelling/en_US.aff"
    system "install -Dm644 dictionaries/en/en_US.dic #{CREW_DEST_DIR}$HOME/Library/Spelling/en_US.dic"
    system "install -Dm644 dictionaries/en/en_US.aff $HOME/Library/Spelling/en_US.aff"
    system "install -Dm644 dictionaries/en/en_US.dic $HOME/Library/Spelling/en_US.dic"
    system "install -Dm644 dictionaries/fr_FR/fr.aff #{CREW_DEST_DIR}$HOME/Library/Spelling/fr_FR.aff"
    system "install -Dm644 dictionaries/fr_FR/fr.dic #{CREW_DEST_DIR}$HOME/Library/Spelling/fr_FR.dic"
    system "install -Dm644 dictionaries/fr_FR/fr.aff $HOME/Library/Spelling/fr_FR.aff"
    system "install -Dm644 dictionaries/fr_FR/fr.dic $HOME/Library/Spelling/fr_FR.dic"
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "echo 'export DICTIONARY=en_US' >> ~/.bashrc && source ~/.bashrc".lightblue
    puts
  end
end
