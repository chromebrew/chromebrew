require 'package'

class Asciidoc < Package
  description 'AsciiDoc is a presentable text document format for writing articles, UNIX man pages and other small to medium sized documents.'
  homepage 'http://asciidoc.org/'
  version '8.6.8'
  source_url 'https://downloads.sourceforge.net/project/asciidoc/asciidoc/8.6.8/asciidoc-8.6.8.tar.gz'
  source_sha256 'ffb67f59dccaf6f15db72fcd04fdf21a2f9b703d31f94fcd0c49a424a9fcfbc4'

  depends_on 'autoconf'
  depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/python"

  def self.build
    system "autoconf"
    system "sed -i 's,/etc/vim,#{CREW_PREFIX}/etc/vim,g' Makefile.in"
    system "./configure"
    system "make"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/etc/vim"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

