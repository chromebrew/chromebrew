require 'package'

class Mupdf < Package
  description 'MuPDF is a lightweight open source software framework for viewing and converting PDF, XPS, and E-book documents.'
  homepage 'https://mupdf.com/'
  version '1.28.4'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ArtifexSoftware/mupdf.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dce91bcf963ecd94c94bd260236aa932f39a8fa875943939bdb2d547a9aa7870',
     armv7l: 'dce91bcf963ecd94c94bd260236aa932f39a8fa875943939bdb2d547a9aa7870',
     x86_64: 'dd6f0d48081eba2444287ad1ee12e284d5f61fd2d6805d364863463ef978c878'
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
