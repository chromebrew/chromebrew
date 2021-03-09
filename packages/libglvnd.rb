require 'package'

class Libglvnd < Package
  description 'The GL Vendor-Neutral Dispatch library'
  homepage 'https://gitlab.freedesktop.org/glvnd/libglvnd'
  version '1.3.2'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/glvnd/libglvnd/-/archive/v1.3.2/libglvnd-v1.3.2.tar.bz2'
  source_sha256 '8eb697a879245c6246ffabf2c1ed72a5ae335769f0772f55cbe4fee3e50223fe'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libglvnd-1.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libglvnd-1.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libglvnd-1.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libglvnd-1.3.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '70735287c0e3ec8a7adc8a0b73ff3094f64fc05033f00a7c97b3b9f135f89b5e',
     armv7l: '70735287c0e3ec8a7adc8a0b73ff3094f64fc05033f00a7c97b3b9f135f89b5e',
       i686: '0539bb9968725480639004fae14c4ef2014d13290ad1353ed8532fb601b9a1db',
     x86_64: '24b0f3aa36dbe3832edc8d2ee787962416f5fb2cac13c1e31d71146adbe9660f',
  })

  depends_on 'libxext'
  depends_on 'libx11'
  depends_on 'glproto'
  depends_on 'python3' => :build

  def self.build
    system "env NOCONFIGURE=1 ./autogen.sh"
    system "./configure #{CREW_OPTIONS} \
            --enable-egl \
            --enable-x11 \
            --enable-glx \
            --enable-gles1 \
            --enable-gles2 \
            --enable-headers \
            --enable-asm \
            --enable-tls"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
