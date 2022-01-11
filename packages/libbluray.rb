require 'package'

class Libbluray < Package
  description 'This library is simply a tool for playback of Blu-ray movies.'
  homepage 'https://www.videolan.org/developers/libbluray.html'
  version '1.3.0'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://get.videolan.org/libbluray/1.3.0/libbluray-1.3.0.tar.bz2'
  source_sha256 'e2dbaf99e84e0a9725f4985bcb85d41e52c2261cc651d8884b1b790b5ef016f9'

  depends_on 'libxml2'
  depends_on 'freetype'
  depends_on 'fontconfig'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
            --enable-optimizations \
            --disable-bdjava-jar"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
