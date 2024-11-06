require 'package'

class Pngcheck < Package
  description 'pngcheck verifies the integrity of PNG, JNG and MNG files'
  homepage 'http://www.libpng.org/pub/png/apps/pngcheck.html'
  version '3.0.2'
  license 'HPND and GPL-2+'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/png-mng/pngcheck/3.0.2/pngcheck-3.0.2.tar.gz'
  source_sha256 '0d7e262f24116fddf2847a8ceb5c92d9f5f26efb42e9fff63ec2bb7676131ca7'

  def self.build
    system 'make', '-f', 'Makefile.unx'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1"
    FileUtils.install 'pngcheck', "#{CREW_DEST_PREFIX}/bin/pngcheck", mode: 0o755
    FileUtils.install 'pngcheck.1', "#{CREW_DEST_MAN_PREFIX}/man1/pngcheck.1", mode: 0o644
  end
end
