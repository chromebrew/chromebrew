require 'package'

class Pipes_sh < Package
  description 'Animated pipes terminal screensaver'
  homepage 'https://pipeseroni.github.io/'
  version '1.3.0'
  compatibility 'all'
  source_url 'https://github.com/pipeseroni/pipes.sh/archive/v1.3.0.tar.gz'
  source_sha256 '532976dd8dc2d98330c45a8bcb6d7dc19e0b0e30bba8872dcce352361655a426'

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} PREFIX=#{CREW_PREFIX} install"
  end
end
