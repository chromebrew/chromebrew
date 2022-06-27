require 'package'

class Mupdf < Package
  description 'MuPDF is a lightweight open source software framework for viewing and converting PDF, XPS, and E-book documents.'
  homepage 'https://mupdf.com/'
  version '1.20.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://mupdf.com/downloads/archive/mupdf-1.20.0-source.tar.lz'
  source_sha256 '68dbb1cf5e31603380ce3f1c7f6c431ad442fa735d048700f50ab4de4c3b0f82'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mupdf/1.20.0_armv7l/mupdf-1.20.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mupdf/1.20.0_armv7l/mupdf-1.20.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mupdf/1.20.0_i686/mupdf-1.20.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mupdf/1.20.0_x86_64/mupdf-1.20.0-chromeos-x86_64.tar.zst',
  })
  binary_sha256 ({
    aarch64: '0a1ce87c5e8252efd0e9afce24e605965c6516623897ca5fd31d495ae0d8c98c',
     armv7l: '0a1ce87c5e8252efd0e9afce24e605965c6516623897ca5fd31d495ae0d8c98c',
       i686: '8002b5e73d5147791e57264100ef56427048d3665e845dce538dd49bdb4042b5',
     x86_64: '31f9ebf66d6e1566ab66a6d9b670a94bdd9378ccb55ff900776844b26cc97bcc',
  })

  depends_on 'freetype'
  depends_on 'jbigkit'
  depends_on 'libjpeg'
  depends_on 'openjpeg'
  depends_on 'freeglut'
  depends_on 'sommelier' unless ARCH == 'i686'

  def self.build
    unless ARCH == 'i686'
      system "make prefix=#{CREW_PREFIX}"
    else
      system "make HAVE_X11=no prefix=#{CREW_PREFIX}"
    end
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
