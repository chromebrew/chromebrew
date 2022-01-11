require 'package'

class Zvbi < Package
  description 'The Zapping VBI library, in short ZVBI, provides functions to capture and decode VBI data.'
  homepage 'http://zapping.sourceforge.net/ZVBI/'
  version '0.2.35-1'
  license 'GPL-2 and LGPL-2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/zapping/zvbi/0.2.35/zvbi-0.2.35.tar.bz2'
  source_sha256 'fc883c34111a487c4a783f91b1b2bb5610d8d8e58dcba80c7ab31e67e4765318'

  depends_on 'libpng'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
