require 'package'

class Mupdf < Package
  description 'MuPDF is a lightweight open source software framework for viewing and converting PDF, XPS, and E-book documents.'
  homepage 'https://mupdf.com/'
  version '1.27.2'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ArtifexSoftware/mupdf.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f5b3a9d402c17e47fd5ee51599241f05129e4130b1261ad460af410581864511',
     armv7l: 'f5b3a9d402c17e47fd5ee51599241f05129e4130b1261ad460af410581864511',
     x86_64: 'c58ce3a9ed4a9ef6b4173b69f4c5f6615d208d38f9d80f07a63e2ea2fa7f08ef'
  })

  depends_on 'freeglut'
  depends_on 'freetype'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :executable_only
  depends_on 'jbigkit'
  depends_on 'libglvnd' => :executable_only
  depends_on 'libjpeg_turbo'
  depends_on 'libx11' => :executable_only
  depends_on 'libxext' => :executable_only
  depends_on 'libxrandr' => :executable_only
  depends_on 'openjpeg'
  depends_on 'openssl' => :executable_only
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
