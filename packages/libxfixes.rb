require 'package'

class Libxfixes < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '6.0.0'
  license 'custom'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXfixes-6.0.0.tar.bz2'
  source_sha256 'a7c1a24da53e0b46cac5aea79094b4b2257321c621b258729bc3139149245b4c'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxfixes/6.0.0_armv7l/libxfixes-6.0.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxfixes/6.0.0_armv7l/libxfixes-6.0.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxfixes/6.0.0_i686/libxfixes-6.0.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxfixes/6.0.0_x86_64/libxfixes-6.0.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '334ba4a7dc7f8578bcc687dead94717e95793cf672e2c081c43b4e2707ef0251',
     armv7l: '334ba4a7dc7f8578bcc687dead94717e95793cf672e2c081c43b4e2707ef0251',
       i686: '9a220768d3e7891c27fd8dd27245df1cf1b1fb0be83a59ca7c77efa3b1d3ddcc',
     x86_64: 'f6d7949392afb2defb0231a28011ecac138d8f3dd744bd2f2c2fcc27e5bcb2a4'
  })

  depends_on 'libx11' # R
  depends_on 'glibc' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
