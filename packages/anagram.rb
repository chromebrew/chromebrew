require 'package'

class Anagram < Package
  description 'finds anagrams or permutations of words in the target phrase'
  homepage 'https://www.fourmilab.ch/anagram/'
  version '1.5'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://www.fourmilab.ch/anagram/anagram-1.5.tar.gz'
  source_sha256 '62eca59318782e889118a0e130d454e1c397aedd99fc59b2194393bf0eff5348'

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
    system "./configure #{CREW_OPTIONS}"
    system 'make'

    @_anagram_wrapper = <<~EOF
      #!/bin/bash -e

      exec #{CREW_PREFIX}/share/anagram/bin/anagram \
        --dictionary #{CREW_PREFIX}/share/anagram/crossword.txt \
        --bindict #{CREW_PREFIX}/share/anagram/wordlist.bin "${@}"
    EOF
  end

  def self.install
    FileUtils.mkdir_p %W[
      #{CREW_DEST_PREFIX}/bin
      #{CREW_DEST_PREFIX}/share/anagram/bin
      #{CREW_DEST_MAN_PREFIX}/man1
    ]

    system "gzip -c -9 anagram.1 > #{CREW_DEST_MAN_PREFIX}/man1/anagram.1.gz"

    File.write "#{CREW_DEST_PREFIX}/bin/anagram", @_anagram_wrapper, perm: 0o755

    FileUtils.install 'anagram', "#{CREW_DEST_PREFIX}/share/anagram/bin", mode: 0o755
    FileUtils.install 'crossword.txt', "#{CREW_DEST_PREFIX}/share/anagram", mode: 0o644
    FileUtils.install 'wordlist.bin', "#{CREW_DEST_PREFIX}/share/anagram", mode: 0o644
  end
end
