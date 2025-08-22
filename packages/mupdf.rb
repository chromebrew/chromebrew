require 'package'

class Mupdf < Package
  description 'MuPDF is a lightweight open source software framework for viewing and converting PDF, XPS, and E-book documents.'
  homepage 'https://mupdf.com/'
  version '1.26.5'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://mupdf.com/downloads/archive/mupdf-#{version}-source.tar.lz"
  source_sha256 'c34cb8dd9b62716bbad66aa6deddd602673fd2da8bf67ae5decba88386f67b83'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2036dd53626d8177623fce6de7c63eba190846dc9aa3d160e8f4d2da0752f7bf',
     armv7l: '2036dd53626d8177623fce6de7c63eba190846dc9aa3d160e8f4d2da0752f7bf',
     x86_64: '48ecef796f515473ca5b36ffd933c37f530a47373eb22d863a135b2b6e11b379'
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
