require 'package'

class Pipesx_sh < Package
  description 'Animated pipes terminal screensaver at an angle'
  homepage 'https://pipeseroni.github.io/'
  version '1.1.0'
  compatibility 'all'
  source_url 'https://github.com/pipeseroni/pipesX.sh/archive/v1.1.0.tar.gz'
  source_sha256 '82e60efbe3e8ae1c83a9b7e5df7d67ccdad3905dfd478f27d2b2be488603420c'

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} PREFIX=#{CREW_PREFIX} install"
  end
end
