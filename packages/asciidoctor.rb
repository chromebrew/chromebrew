require 'package'

class Asciidoctor < Package
  description 'A fast text processor & publishing toolchain for converting AsciiDoc to HTML5, DocBook & more.'
  homepage 'https://asciidoctor.org/'
  version '2.0.10'
  compatibility 'all'
  source_url 'https://github.com/asciidoctor/asciidoctor/archive/v2.0.10.tar.gz'
  source_sha256 'afca74837e6d4b339535e8ba0b79f2ad00bd1eef78bf391cc36995ca2e31630a'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/asciidoctor"
    FileUtils.cp_r Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/asciidoctor"
    system "install -Dm644 man/asciidoctor.1 #{CREW_DEST_MAN_PREFIX}/man1/asciidoctor.1"
    FileUtils.ln_s "#{CREW_PREFIX}/share/asciidoctor/bin/asciidoctor", "#{CREW_DEST_PREFIX}/bin/asciidoctor"
  end
end
