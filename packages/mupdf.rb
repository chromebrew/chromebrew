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
    aarch64: '0e04ee81794bc36f7d41d5be1eaabc93ec8e2dd21e1903d8eb5f65d67e137293',
     armv7l: '0e04ee81794bc36f7d41d5be1eaabc93ec8e2dd21e1903d8eb5f65d67e137293',
     x86_64: '985be5e4d41ee15849e0b06fa1019275eb119c3caec74ef5954f5ec924964cb9'
  })

  depends_on 'freeglut'
  depends_on 'freetype'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'jbigkit'
  depends_on 'libglvnd' # R
  depends_on 'libjpeg_turbo'
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxrandr' # R
  depends_on 'openjpeg'
  depends_on 'openssl' # R
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
