require 'buildsystems/autotools'

class Npth < Autotools
  description 'nPth is a library to provide the GNU Pth API and thus a non-preemptive threads implementation.'
  homepage 'https://www.gnupg.org/related_software/npth/index.html'
  version '1.7'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://www.gnupg.org/ftp/gcrypt/npth/npth-1.6.tar.bz2'
  source_sha256 '1393abd9adcf0762d34798dc34fdcf4d0d22a8410721e76f1e3afcd1daa4e2d1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '53670d54a7d4e88a6899d1868ffba42b1d50d0865c826f144485818537e1baf4',
     armv7l: '53670d54a7d4e88a6899d1868ffba42b1d50d0865c826f144485818537e1baf4',
       i686: '561238e45c64d003c14603c094d65351690e32390918d09a1bf25f40f8ee8b49',
     x86_64: 'a1f2db1d9476a48bb49014cede645b17ae65fd9d289062d74d040e3092d0764b'
  })

  depends_on 'glibc' # R
end
