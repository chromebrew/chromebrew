require 'package'

class Libxfont2 < Package
  description 'X.org X font library'
  homepage 'http://www.x.org'
  version '2.0.4'
  license 'MIT'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXfont2-2.0.4.tar.bz2'
  source_sha256 '6d151b3368e5035efede4b6264c0fdc6662c1c99dbc2de425e3480cababc69e6'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxfont2/2.0.4_armv7l/libxfont2-2.0.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxfont2/2.0.4_armv7l/libxfont2-2.0.4-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxfont2/2.0.4_i686/libxfont2-2.0.4-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxfont2/2.0.4_x86_64/libxfont2-2.0.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3ac6d734039ec97440aafcbd2da119114e2a47d18568d3403eab5f529c32f20b',
     armv7l: '3ac6d734039ec97440aafcbd2da119114e2a47d18568d3403eab5f529c32f20b',
       i686: '7d1a020408724012ecce6eac21326a4d922753321cf65e50cccb3731764f5679',
     x86_64: '2de5392e181a0f94794b888eec55bc35b0e26cb8f69ca0f77394b9d7e887ef1b',
  })

  depends_on 'fop' => :build
  depends_on 'libxtrans'
  depends_on 'libfontenc'
  depends_on 'libx11'
  depends_on 'freetype_sub'
  depends_on 'xmlto' => :build

  def self.build
    # WARNING: Run `crew remove libbsd` before attempting to compile.
    # See https://crux.nu/bugs/?do=details&task_id=1784.
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
