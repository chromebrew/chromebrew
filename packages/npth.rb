require 'buildsystems/autotools'

class Npth < Autotools
  description 'nPth is a library to provide the GNU Pth API and thus a non-preemptive threads implementation.'
  homepage 'https://www.gnupg.org/related_software/npth/index.html'
  version '1.8'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/npth/npth-#{version}.tar.bz2"
  source_sha256 '8bd24b4f23a3065d6e5b26e98aba9ce783ea4fd781069c1b35d149694e90ca3e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '72af97e008ec176fd89b3f041437469ccaf89d37189cd8e506bc4691a67fbb96',
     armv7l: '72af97e008ec176fd89b3f041437469ccaf89d37189cd8e506bc4691a67fbb96',
       i686: '8c6ea35dc2cfa6f6ab6e1062d793b6a3b55dc6584f234b03a20b2d5ec32d6849',
     x86_64: '3d89fce64d6f9b33f4bbf3d1a23ad300862a7561632c0cd9850c27df605abf33'
  })

  depends_on 'glibc' # R

  run_tests
end
