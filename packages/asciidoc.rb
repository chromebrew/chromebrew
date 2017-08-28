require 'package'

class Asciidoc < Package
  description 'AsciiDoc is a presentable text document format for writing articles, UNIX man pages and other small to medium sized documents.'
  homepage 'http://asciidoc.org/'
  version '8.6.8'
  source_url 'https://downloads.sourceforge.net/project/asciidoc/asciidoc/8.6.8/asciidoc-8.6.8.tar.gz'
  source_sha256 'ffb67f59dccaf6f15db72fcd04fdf21a2f9b703d31f94fcd0c49a424a9fcfbc4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/asciidoc-8.6.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/asciidoc-8.6.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/asciidoc-8.6.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/asciidoc-8.6.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8964ae17ca0feef6ee98d89139a27a3f6fddf9b20cad7c6d62efc31b842227a2',
     armv7l: '8964ae17ca0feef6ee98d89139a27a3f6fddf9b20cad7c6d62efc31b842227a2',
       i686: 'bfbcc0789959c06eda29a0ce1d2cac7d8120d103581ba75fd8f899b69b75d309',
     x86_64: '035b371c2dd72ef63d2c0dbeb1671ca1de9babb33ae8226153684d3d0904ca0d',
  })

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

