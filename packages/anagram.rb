require 'package'

class Anagram < Package
  description 'finds anagrams or permutations of words in the target phrase'
  homepage 'http://www.fourmilab.ch/anagram/'
  version '1.4'
  source_url 'http://www.fourmilab.ch/anagram/anagram-1.4.tar.gz'
  source_sha256 'd046fd5accd3c62267c0ef81b56cd05c59ec92b37cdb73f69d031879dba308bd'

  binary_url ({
  })
  binary_sha256 ({
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
