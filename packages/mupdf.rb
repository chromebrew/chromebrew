require 'package'

class Mupdf < Package
  description 'MuPDF is a lightweight open source software framework for viewing and converting PDF, XPS, and E-book documents.'
  homepage 'https://mupdf.com/'
  version '1.28.5'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ArtifexSoftware/mupdf.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '11065d86cd5e2868d9ce14cbb497f95d62a68801f0aa5a74a990d05995825cb8',
     armv7l: '11065d86cd5e2868d9ce14cbb497f95d62a68801f0aa5a74a990d05995825cb8',
     x86_64: '7e5c934f48873b17195824306fb43cee97c438a0a9a242e7f7102c7eba89590b'
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
