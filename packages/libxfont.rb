require 'package'

class Libxfont < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '2.0.1'
  license 'custom'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXfont2-2.0.1.tar.gz'
  source_sha256 '381b6b385a69343df48a082523c856aed9042fbbc8ee0a6342fb502e4321230a'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxfont/2.0.1_armv7l/libxfont-2.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxfont/2.0.1_armv7l/libxfont-2.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxfont/2.0.1_i686/libxfont-2.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxfont/2.0.1_x86_64/libxfont-2.0.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd8c0c65c7a09a22609e0f80ed208430c20d27fad1f8da2126e1bf232a1c4269f',
     armv7l: 'd8c0c65c7a09a22609e0f80ed208430c20d27fad1f8da2126e1bf232a1c4269f',
       i686: '974ffccd0db96a57f9f3df1b08901b1116a9a570072d8bf3a6f716e8046e07c5',
     x86_64: 'a39664217180079324ce09fb7d341b3d02c9eb479b32c709447d9fea8561ecaf'
  })

  depends_on 'libfontenc'
  depends_on 'freetype'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
