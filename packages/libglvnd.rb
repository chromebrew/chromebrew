require 'package'

class Libglvnd < Package
  description 'The GL Vendor-Neutral Dispatch library'
  homepage 'https://gitlab.freedesktop.org/glvnd/libglvnd'
  version '1.3.2'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/glvnd/libglvnd/-/archive/v1.3.2/libglvnd-v1.3.2.tar.bz2'
  source_sha256 '8eb697a879245c6246ffabf2c1ed72a5ae335769f0772f55cbe4fee3e50223fe'

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
