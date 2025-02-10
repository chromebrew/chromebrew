require 'package'

class Mupdf < Package
  description 'MuPDF is a lightweight open source software framework for viewing and converting PDF, XPS, and E-book documents.'
  homepage 'https://mupdf.com/'
  version '1.24.9'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://mupdf.com/downloads/archive/mupdf-#{version}-source.tar.lz"
  source_sha256 'd87da097ae943ad0113003190ed370d39bde817383c59dc753dce23c7ba2b710'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8ae34fefdcf2ffb842c2f643b044561a356fc4b3a6fe7972aed077a103ca5581',
     armv7l: '8ae34fefdcf2ffb842c2f643b044561a356fc4b3a6fe7972aed077a103ca5581',
     x86_64: '6f4cd7df402ba79a07198e7df47fe7429482211262e7b93a7c12e442f55b5244'
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

  def self.postinstall
    ExitMessage.add "\nType 'mupdf-gl' to get started.\n"
  end
end
