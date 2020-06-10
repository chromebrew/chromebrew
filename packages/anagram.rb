require 'package'

class Anagram < Package
  description 'finds anagrams or permutations of words in the target phrase'
  homepage 'http://www.fourmilab.ch/anagram/'
  version '1.4'
  compatibility 'all'
  source_url 'http://www.fourmilab.ch/anagram/anagram-1.4.tar.gz'
  source_sha256 'd046fd5accd3c62267c0ef81b56cd05c59ec92b37cdb73f69d031879dba308bd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/anagram-1.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/anagram-1.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/anagram-1.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/anagram-1.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5d5e2fa0868d99ed24623a1fd98bf9a00a07c50e5a8c931cf2d43ab3dfbf1a42',
     armv7l: '5d5e2fa0868d99ed24623a1fd98bf9a00a07c50e5a8c931cf2d43ab3dfbf1a42',
       i686: '33dbe4fd1116e429e1b927f63de8361b3ba888f24712ae692bee0ac152bc41b7',
     x86_64: '2d162c9d06d59ee1dab520deccfed04e3c27f7a5584346dfdc2e267bc46d310c',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
    system 'mkdir build'
    Dir.chdir 'build' do
      system "echo '#!/bin/bash' > anagram"
      system "echo '#{CREW_PREFIX}/share/anagram/bin/anagram --dictionary #{CREW_PREFIX}/share/anagram/crossword.txt --bindict #{CREW_PREFIX}/share/anagram/wordlist.bin $@' >> anagram"
    end
  end

  def self.install
    system "gzip -9 anagram.1"
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/anagram/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/man/man1"
    system "install -Dm755 build/anagram #{CREW_DEST_PREFIX}/bin"
    system "install -Dm755 anagram #{CREW_DEST_PREFIX}/share/anagram/bin"
    system "install -Dm644 crossword.txt #{CREW_DEST_PREFIX}/share/anagram"
    system "install -Dm644 wordlist.bin #{CREW_DEST_PREFIX}/share/anagram"
    system "install -Dm644 anagram.1.gz #{CREW_DEST_PREFIX}/share/man/man1"
  end
end
