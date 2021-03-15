require 'package'

class Hashpipe < Package
  description 'Hash in a pipe'
  homepage 'https://git.zx2c4.com/hashpipe/about/#hashpipe'
  version '1.0'
  compatibility 'all'
  source_url 'https://git.zx2c4.com/hashpipe/snapshot/hashpipe-dc11b6262f4717e61e55760cb2bd637ff1c0f6a9.tar.xz'
  source_sha256 '6b3931d7c46332be2a6c07f94f91924065ba7988edd2e8a471123c77d3c614f6'

  def self.build
    system "make PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} make PREFIX=#{CREW_PREFIX} install"
  end
end
