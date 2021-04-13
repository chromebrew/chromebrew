require 'package'

class Gsound < Package
  description 'GSound is a small library for playing system sounds.'
  homepage 'https://wiki.gnome.org/Projects/GSound'
  @_app = File.basename(__FILE__, '.rb').tr('_', '-')
  @_fullver = '1.0.2'
  @_mainver = @_fullver.rpartition('.')[0]
  @_url = "https://download.gnome.org/sources/#{@_app}/#{@_mainver}/#{@_app}-#{@_fullver}"
  version @_fullver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "#{@_url}.tar.xz"
  source_sha256 `curl -Ls #{@_url}.sha256sum | tail -n1 | cut -d ' ' -f1`.chomp

  binary_url ({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/gsound-1.0.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/gsound-1.0.2-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/gsound-1.0.2-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/gsound-1.0.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '01781a6b9044780e7e4401e16fa6ba3a3491cff618e640828445937dcce90155',
     armv7l: '01781a6b9044780e7e4401e16fa6ba3a3491cff618e640828445937dcce90155',
       i686: '468fe3ee02fd4899516fc7144b1454a0b7ee5296832f7983e5cd92c547f949e8',
     x86_64: '65a98713abd0ad892ba0f65a823d51c5aa1b9fd14751d998211f762724a2c444',
  })

  depends_on 'gobject_introspection'
  depends_on 'libcanberra'

  def self.build
    system './autogen.sh' if File.exist?('autogen.sh')
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'  LDFLAGS='-flto=auto' \
            ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system "make", "check"
  end
end
