require 'package'

class Mupdf < Package
  description 'MuPDF is a lightweight open source software framework for viewing and converting PDF, XPS, and E-book documents.'
  homepage 'https://mupdf.com/'
  version '1.28.0'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ArtifexSoftware/mupdf.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6f1b9a1cd0229bc98b9dec54daa069871eadc4a2ca54b7b0afb215ef806e44b4',
     armv7l: '6f1b9a1cd0229bc98b9dec54daa069871eadc4a2ca54b7b0afb215ef806e44b4',
     x86_64: 'f5b975c2ed9764b158cf45dac482b68c7578704c931840221b178d173a4dbc84'
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
