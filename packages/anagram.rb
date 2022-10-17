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
    aarch64: '86cba09c62c088c62405e95f844312efeb9b376ea05af25c54b8bae33834405d',
     armv7l: '86cba09c62c088c62405e95f844312efeb9b376ea05af25c54b8bae33834405d',
       i686: 'd71541b068c8a1348c6982cf4a25695789f8c97102b9a97962cc1c6573f9d294',
     x86_64: '261cccedc4ccfd4dfb5351bed6444ab2183800bfe5bd3f34f5332fe966e42c43'
  })

  depends_on 'glibc' # R

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
