require 'package'

class Mupdf < Package
  description 'MuPDF is a lightweight open source software framework for viewing and converting PDF, XPS, and E-book documents.'
  homepage 'https://mupdf.com/'
  version '1.24.4'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://mupdf.com/downloads/archive/mupdf-1.24.4-source.tar.lz'
  source_sha256 '1a389c1ce32350eb019d0bee5a318661e3dcf62ba27869f59d79526376e07118'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '985909f0391d0d59f4da27cb8f87079cac118d64551fc142395aca274aa42be4',
     armv7l: '985909f0391d0d59f4da27cb8f87079cac118d64551fc142395aca274aa42be4',
     x86_64: '15abdd43c940ba1b695dacdfaed58c0d4ad0809abf3b8a01fdfee91a81343b24'
  })

  depends_on 'freeglut'
  depends_on 'freetype'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'jbigkit'
  depends_on 'curl' # R
  depends_on 'libjpeg_turbo'
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxrandr' # R
  depends_on 'mesa' # R
  depends_on 'openjpeg'
  depends_on 'openssl' # R
  depends_on 'sommelier' unless ARCH == 'i686'

  def self.build
    if ARCH == 'i686'
      system "make HAVE_X11=no prefix=#{CREW_PREFIX}"
    else
      system "make prefix=#{CREW_PREFIX}"
    end
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
