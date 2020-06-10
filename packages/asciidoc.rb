require 'package'

class Asciidoc < Package
  description 'AsciiDoc is a presentable text document format for writing articles, UNIX man pages and other small to medium sized documents.'
  homepage 'http://asciidoc.org/'
  version '8.6.9-1'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/asciidoc/asciidoc/8.6.9/asciidoc-8.6.9.tar.gz'
  source_sha256 '78db9d0567c8ab6570a6eff7ffdf84eadd91f2dfc0a92a2d0105d323cab4e1f0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/asciidoc-8.6.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/asciidoc-8.6.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/asciidoc-8.6.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/asciidoc-8.6.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '913147e51102cd8938ac8c3dcf7520c2995c081b1ba9ee097539cf83b3557a96',
     armv7l: '913147e51102cd8938ac8c3dcf7520c2995c081b1ba9ee097539cf83b3557a96',
       i686: '24df5bebe051fe916d7bf722b85bea5e0b8dbe099e2b95e2fbee609b22c14639',
     x86_64: '048de56fd444c9c5542270fb8080b23f0264467e3c10853b9925b4add914b053',
  })

  depends_on 'autoconf' => :build
  depends_on 'compressdoc' => :build
  depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/python"

  def self.build
    system "autoconf"
    system "sed -i 's,/etc/vim,#{CREW_PREFIX}/etc/vim,g' Makefile.in"
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/etc/vim"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man1"
  end
end

