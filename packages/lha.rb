require 'package'

class Lha < Package
  description 'LHa for UNIX is a console-based utility that uncompresses and compresses .lha packages.'
  homepage 'https://lha.osdn.jp/'
  version '2695022'
  license 'lha'
  compatibility 'all'
  source_url 'https://github.com/jca02266/lha.git'
  git_hashtag '26950220c9c7590fd603ecaa54a12a52371affed'

  def self.build
    system 'autoreconf -sif'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
