require 'package'

class Asciidoc < Package
  description 'AsciiDoc is a presentable text document format for writing articles, UNIX man pages and other small to medium sized documents.'
  homepage 'http://asciidoc.org/'
  @_ver = '9.1.0'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url "https://github.com/asciidoc/asciidoc-py3/releases/download/#{@_ver}/asciidoc-#{@_ver}.tar.gz"
  source_sha256 'fd499fcf51317b1aaf27336fb5e919c44c1f867f1ae6681ee197365d3065238b'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/asciidoc-9.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/asciidoc-9.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/asciidoc-9.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/asciidoc-9.1.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '2b38a7ec2050abd4df05fe90a4bb85199c3d45d7961ad0c5bcbf065b2f411857',
     armv7l: '2b38a7ec2050abd4df05fe90a4bb85199c3d45d7961ad0c5bcbf065b2f411857',
       i686: '2ff48243579ceb94ebcbda0ee8b5f626dcae7d42494260eda8b24a4d430b6e75',
     x86_64: 'f666c49abfa66b17013130de84ad2822f9ffbaa48063f1d742950d5acea1f3f1'
  })

  def self.build
    system 'autoconf'
    system "sed -i 's,/etc/vim,#{CREW_PREFIX}/etc/vim,g' Makefile.in"
    system "env CFLAGS='-flto=auto' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/etc/vim"
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man1"
  end
end
