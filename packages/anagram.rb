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
    aarch64: '60eb2350a7133d51a49e92ff958136e1b9dc81c4dd8ef7b75df3f0bd4907dcf0',
     armv7l: '60eb2350a7133d51a49e92ff958136e1b9dc81c4dd8ef7b75df3f0bd4907dcf0',
       i686: 'e9079eddb55e0f0c9a660c761394355ef5b8d755bdd457ca2c591388a0e8f10a',
     x86_64: '5e02d9bf17529e1db392e014b193f528b3c2fd990e758be3f023478b56ac9975'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'

    @_anagram_wrapper = <<~ANAGRAM_WRAPPER_EOF
      #!/bin/bash -e

      exec #{CREW_PREFIX}/share/anagram/bin/anagram \
        --dictionary #{CREW_PREFIX}/share/anagram/crossword.txt \
        --bindict #{CREW_PREFIX}/share/anagram/wordlist.bin "${@}"
    ANAGRAM_WRAPPER_EOF
    File.write 'anagram_wrapper', @_anagram_wrapper, perm: 0o755
  end

  def self.install
    FileUtils.install 'anagram', "#{CREW_DEST_PREFIX}/share/anagram/bin", mode: 0o755
    FileUtils.install 'anagram_wrapper', "#{CREW_DEST_PREFIX}/bin/anagram", mode: 0o755
    FileUtils.install 'anagram.1', "#{CREW_DEST_MAN_PREFIX}/man1/anagram.1", mode: 0o644
    FileUtils.install 'crossword.txt', "#{CREW_DEST_PREFIX}/share/anagram", mode: 0o644
    FileUtils.install 'wordlist.bin', "#{CREW_DEST_PREFIX}/share/anagram", mode: 0o644
  end
end
