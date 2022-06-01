require 'package'

class Asciidoc < Package
  description 'AsciiDoc is a presentable text document format for writing articles, UNIX man pages and other small to medium sized documents.'
  homepage 'http://asciidoc.org/'
  @_ver = '10.1.4'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url "https://github.com/asciidoc/asciidoc-py3/releases/download/#{@_ver}/asciidoc-#{@_ver}.tar.gz"
  source_sha256 'e4da7cc2af7fa12029156c0788fde2a53db1352d7dcb3e674a9d546b3bdba93f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoc/10.1.4_armv7l/asciidoc-10.1.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoc/10.1.4_armv7l/asciidoc-10.1.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoc/10.1.4_i686/asciidoc-10.1.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoc/10.1.4_x86_64/asciidoc-10.1.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8aa6102c4aa68f5d8309af9ebfb27b683b8e636634dc526ec1d3a563b12af962',
     armv7l: '8aa6102c4aa68f5d8309af9ebfb27b683b8e636634dc526ec1d3a563b12af962',
       i686: 'd86b85c86cbbf6e47edf276c72acaa88d2961332806e2b5ce71212db4fcb51b7',
     x86_64: '7cdf448d6defb19aed9dcdfa41010349334719cef7c7d52fe65f564cf1699049'
  })

  def self.build
    system 'autoconf'
    system "sed -i 's,/etc/vim,#{CREW_PREFIX}/etc/vim,g' Makefile.in"
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/etc/vim"
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
