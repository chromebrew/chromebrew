require 'package'

class Rxvt_unicode < Package
  description 'A fork of the well known terminal emulator rxvt.'
  homepage 'http://software.schmorp.de/pkg/rxvt-unicode.html'
  version '9.30'
  license 'GPL-3'
  compatibility 'all'
  source_url 'http://dist.schmorp.de/rxvt-unicode/rxvt-unicode-9.30.tar.bz2'
  source_sha256 'fe1c93d12f385876457a989fc3ae05c0915d2692efc59289d0f70fabe5b44d2d'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rxvt_unicode/9.30_armv7l/rxvt_unicode-9.30-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rxvt_unicode/9.30_armv7l/rxvt_unicode-9.30-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rxvt_unicode/9.30_i686/rxvt_unicode-9.30-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rxvt_unicode/9.30_x86_64/rxvt_unicode-9.30-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b23e4d4e20911d6e8085e8867358f9cb189d599c1733edc994504de55147261a',
     armv7l: 'b23e4d4e20911d6e8085e8867358f9cb189d599c1733edc994504de55147261a',
       i686: 'd0d24b033752ea7191b8d2ef8990a79ac14192deb72e231f8cf4e43f1f5530d7',
     x86_64: '4393a4bdb819213b05deb41b0a713e81b52ad0f786c095dd77fe2f03e0a8452c'
  })

  depends_on 'gdk_pixbuf'
  depends_on 'libptytty'
  depends_on 'sommelier'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
