require 'package'

class Libraw < Package
  description 'Raw image decoder library'
  homepage 'https://www.libraw.org'
  version '0.20.2'
  license 'LGPL-2.1 and CDDL'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://www.libraw.org/data/LibRaw-0.20.2.tar.gz'
  source_sha256 'dc1b486c2003435733043e4e05273477326e51c3ea554c6864a4eafaff1004a6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8c49ae291667a77b2656a9530f7aa3afcc5ba60849b421c122384c9be24fb80b',
     armv7l: '8c49ae291667a77b2656a9530f7aa3afcc5ba60849b421c122384c9be24fb80b',
     x86_64: 'e73d06cfb8317be20e801930eba8b4f96c9e0d1a021594f66164972441e600d1'
  })

  depends_on 'jasper'
  depends_on 'lcms'
  depends_on 'openmp'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libjpeg' # R
  depends_on 'zlibpkg' # R

  def self.build
    system 'autoreconf -fiv'
    system 'filefix'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
