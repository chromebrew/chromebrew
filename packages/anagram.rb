require 'package'

class Anagram < Package
  description 'finds anagrams or permutations of words in the target phrase'
  homepage 'http://www.fourmilab.ch/anagram/'
  version '1.4'
  license 'public-domain'
  compatibility 'all'
  source_url 'http://www.fourmilab.ch/anagram/anagram-1.4.tar.gz'
  source_sha256 'd046fd5accd3c62267c0ef81b56cd05c59ec92b37cdb73f69d031879dba308bd'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/anagram/1.5_armv7l/anagram-1.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/anagram/1.5_armv7l/anagram-1.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/anagram/1.5_i686/anagram-1.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/anagram/1.5_x86_64/anagram-1.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bd706becd9f34cd71f52f2b646daf1e460d9e8a4d685a7d0673492e3c64dec65',
     armv7l: 'bd706becd9f34cd71f52f2b646daf1e460d9e8a4d685a7d0673492e3c64dec65',
       i686: 'd4d2c9d78995d454e72879e07485c3e69f127c0a9571def97a469b9e9a6a9b55',
     x86_64: '2e7f200199054471c7512c1c667f0d52459a1ffda17497b6d531f87b2680df36'
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
    system 'gzip -9 anagram.1'
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
