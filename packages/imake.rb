require 'package'

class Imake < Package
  description 'A build automation system written for the X Window System.'
  homepage 'https://x.org'
  version '1.0.8'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/util/imake-1.0.8.tar.gz'
  source_sha256 '8178a09bfef33ad5f61cb5cb62283df7d3a5682f014507d2e7cfd922485a5c00'

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --sysconfdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
