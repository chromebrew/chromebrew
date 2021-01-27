require 'package'

class Asciidoc < Package
  description 'AsciiDoc is a presentable text document format for writing articles, UNIX man pages and other small to medium sized documents.'
  homepage 'http://asciidoc.org/'
  @_ver = '9.0.5'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/asciidoc/asciidoc-py3/releases/download/#{@_ver}/asciidoc-#{@_ver}.tar.gz"
  source_sha256 '1a20647eb62ca37bc8107affab968caa0f674f0e962b497d1674391f636c7038'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/asciidoc-9.0.5-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/asciidoc-9.0.5-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/asciidoc-9.0.5-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/asciidoc-9.0.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '60bba587c331dc462a70dd59a6b7cc68cc08c79a836dde47fe07de6735daa090',
      armv7l: '60bba587c331dc462a70dd59a6b7cc68cc08c79a836dde47fe07de6735daa090',
        i686: '48be337c603382c032d4aaebd0ff4e47341a82aa7429f518c83e1860b390d276',
      x86_64: 'a9fabec30cf8243847e065188568f048d3323f2cc52e47cc8a8aa516b68957cb',
  })

  depends_on 'autoconf' => :build
  depends_on 'compressdoc' => :build
  depends_on 'python3'

  def self.build
    system "autoconf"
    system "sed -i 's,/etc/vim,#{CREW_PREFIX}/etc/vim,g' Makefile.in"
    system "./configure --help"
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/etc/vim"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man1"
  end
end
