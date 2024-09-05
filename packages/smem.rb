require 'package'

class Smem < Package
  description 'A Linux memory reporting tool that uses proportional set size.'
  homepage 'https://www.selenic.com/smem/'
  version '1.5'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://selenic.com/repo/smem/archive/#{version}.tar.bz2"
  source_sha256 '950c39ee8b1e051866564b25c36a6113eae2617e597b8302324bb8ee57d82ba6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9b525a1287322f8a3d152031b34963d471e74f30101af27c1bc2cee5ffff7e42',
     armv7l: '9b525a1287322f8a3d152031b34963d471e74f30101af27c1bc2cee5ffff7e42',
       i686: 'f63a138b571fd6f391bc823007f2649b6ac2f6cb75c2495e1540cf30adb048b2',
     x86_64: '28884e546d36071a800018570f84c95847332d66f592743acb553ccc0f2e2509'
  })

  depends_on 'python3'

  def self.build
    system 'make smemcap'
  end

  def self.install
    FileUtils.install 'smem', "#{CREW_DEST_PREFIX}/bin/smem", mode: 0o755
    FileUtils.install 'smemcap', "#{CREW_DEST_PREFIX}/bin/smemcap", mode: 0o755
    FileUtils.install 'smem.8', "#{CREW_DEST_MAN_PREFIX}/man8/smem.8", mode: 0o644
  end
end
