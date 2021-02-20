require 'package'

class Motti < Package
  description 'GNU Motti is a simple multiplayer strategy game.'
  homepage 'https://www.gnu.org/software/motti/'
  version '3.1.1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/motti/motti-3.1.1.tar.gz'
  source_sha256 '632d9a84d3b2e3eee4c9d9199d66d42576516ea6c291058c01830ae2fb7de429'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
