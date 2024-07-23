require 'package'

class Lzop < Package
  description 'lzop is a file compressor which is very similar to gzip.'
  homepage 'http://www.lzop.org/'
  version '1.04-1'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://www.lzop.org/download/lzop-1.04.tar.gz'
  source_sha256 '7e72b62a8a60aff5200a047eea0773a8fb205caf7acbe1774d95147f305a2f41'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '12444f80e88a657a9b03aa3567c9c69fd8778c0e178f26c79e82b56f7028efbb',
     armv7l: '12444f80e88a657a9b03aa3567c9c69fd8778c0e178f26c79e82b56f7028efbb',
       i686: '270dc22baf06be6742378ace4a6605f2270c36907eab53a78bd9554d72b4e3bc',
     x86_64: 'ad20f5a37b0f564cf2a06c1e516ecbacf5d13d4dcec0cc678eb07364ff5cd2e9'
  })

  depends_on 'lzo'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           '--disable-maintainer-mode',
           '--disable-dependency-tracking'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
