require 'package'

class Xxhash < Package
  description 'xxHash is an extremely fast non-cryptographic hash algorithm, working at speeds close to RAM limits.'
  homepage 'https://cyan4973.github.io/xxHash/'
  version '0.7.3'
  source_url 'https://github.com/Cyan4973/xxHash/archive/v0.7.3.tar.gz'
  source_sha256 '952ebbf5b11fbf59ae5d760a562d1e9112278f244340ad7714e8556cbe54f7f7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.7.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.7.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.7.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.7.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ebc5da796fed9aa28b1d1dfea223be7b82cb2b10a089a3fe17da44a526ce6d7f',
     armv7l: 'ebc5da796fed9aa28b1d1dfea223be7b82cb2b10a089a3fe17da44a526ce6d7f',
       i686: '5c4d9bf621e94373d0453f06a0a1fbd8f10002ba24f53355580eb52316653875',
     x86_64: 'af56f28e9ef99aefed260fb19f931f9ddbe2ec1bdd22a90138e66f76ccbbe203',
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
