require 'package'

class Autoconf_archive < Package
  description 'GNU Autoconf Archive is a collection of freely re-usable Autoconf macros.'
  homepage 'https://www.gnu.org/software/autoconf-archive/'
  version '2017-03-21'
  source_url 'http://ftpmirror.gnu.org/autoconf-archive/autoconf-archive-2017.03.21.tar.xz'
  source_sha256 '386ad455f12bdeb3a7d19280441a5ab77355142349200ff11040a8d9d455d765'

  depends_on 'perl'
  depends_on 'm4'
  depends_on 'autoconf'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
