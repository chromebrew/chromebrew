require 'package'

class Mupdf < Package
  description 'MuPDF is a lightweight open source software framework for viewing and converting PDF, XPS, and E-book documents.'
  homepage 'https://mupdf.com/'
  version '1.28.2'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ArtifexSoftware/mupdf.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '30b76f3007d49ccc89e541ab9a0564ccb639777a1568f1f9107c1812b04e3130',
     armv7l: '30b76f3007d49ccc89e541ab9a0564ccb639777a1568f1f9107c1812b04e3130',
     x86_64: '368506f097f19f83fecdd1a2ec62928e26422be92e1570028a397fd723ad365d'
  })

  depends_on 'freeglut'
  depends_on 'freetype'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'jbigkit'
  depends_on 'libglvnd' => :executable
  depends_on 'libjpeg_turbo'
  depends_on 'libx11' => :executable
  depends_on 'libxext' => :executable
  depends_on 'libxrandr' => :executable
  depends_on 'openjpeg'
  depends_on 'openssl' => :executable
  depends_on 'sommelier' => :logical unless ARCH == 'i686'

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
