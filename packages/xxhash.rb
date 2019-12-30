require 'package'

class Xxhash < Package
  description 'xxHash is an extremely fast non-cryptographic hash algorithm, working at speeds close to RAM limits.'
  homepage 'https://cyan4973.github.io/xxHash/'
  version '0.7.2'
  source_url 'https://github.com/Cyan4973/xxHash/archive/v0.7.2.tar.gz'
  source_sha256 '7e93d28e81c3e95ff07674a400001d0cdf23b7842d49b211e5582d00d8e3ac3e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.7.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.7.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.7.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.7.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '13b8a0673cc01d5c84196dbe821e905acfa8057ad2a44804dbe9169eda8039ea',
     armv7l: '13b8a0673cc01d5c84196dbe821e905acfa8057ad2a44804dbe9169eda8039ea',
       i686: '27202803f014e22ab41ca0729adeb618c4bae2c6710773a0a77e81357743eb64',
     x86_64: '12e1f37a20e71fb5b6e685136c547ee0eff33d13457b459a67636bdd21f609ec',
  })

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    FileUtils.mkdir_p ["#{CREW_DEST_PREFIX}/bin", "#{CREW_DEST_PREFIX}/man/man1"]
    FileUtils.cp 'xxhsum', "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.cp 'xxhsum.1', "#{CREW_DEST_PREFIX}/man/man1/"
  end
end
