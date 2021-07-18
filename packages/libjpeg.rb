require 'package'

class Libjpeg < Package
  description 'JPEG is a free library for image compression.'
  homepage 'https://www.ijg.org/'
  version '8.4.0'
  license 'custom' # Very similar to the BSD license
  compatibility 'all'
  source_url 'https://www.ijg.org/files/jpegsrc.v8d.tar.gz'
  source_sha256 'd625ad6b3375a036bf30cd3b0b40e8dde08f0891bfd3a2960650654bdb50318c'

  binary_url({
  })
  binary_sha256({
  })

  def self.build
    system '[ -x configure ] || ./bootstrap.py'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
