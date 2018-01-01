require 'package'

class Asciidoc < Package
  description 'AsciiDoc is a presentable text document format for writing articles, UNIX man pages and other small to medium sized documents.'
  homepage 'http://asciidoc.org/'
  version '8.6.9'
  source_url 'https://downloads.sourceforge.net/project/asciidoc/asciidoc/8.6.9/asciidoc-8.6.9.tar.gz'
  source_sha256 '78db9d0567c8ab6570a6eff7ffdf84eadd91f2dfc0a92a2d0105d323cab4e1f0'

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

