require 'package'

class Mupdf < Package
  description 'MuPDF is a lightweight open source software framework for viewing and converting PDF, XPS, and E-book documents.'
  homepage 'https://mupdf.com/'
  version '1.20.3'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://mupdf.com/downloads/archive/mupdf-1.20.3-source.tar.lz'
  source_sha256 '6f73f63ef8aa81991dfd023d4426a548827d1d74e0bfcf2a013acad63b651868'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mupdf/1.20.3_armv7l/mupdf-1.20.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mupdf/1.20.3_armv7l/mupdf-1.20.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mupdf/1.20.3_i686/mupdf-1.20.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mupdf/1.20.3_x86_64/mupdf-1.20.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5f4c38504fe42b4ec81e1f30954a5fe10acd5ab4c9f8ffaacd308f881cca11eb',
     armv7l: '5f4c38504fe42b4ec81e1f30954a5fe10acd5ab4c9f8ffaacd308f881cca11eb',
       i686: '76189a9e7138b4380a24470ce7010f95d50db15be74f980294d5b8d33c95010d',
     x86_64: '4ce6bdbb132b435eadc824639e460b159e753b8d40c79a4815aa6b7299dfcf04'
  })

  depends_on 'freeglut'
  depends_on 'freetype'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'jbigkit'
  depends_on 'curl' # R
  depends_on 'libjpeg'
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
