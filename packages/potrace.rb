require 'package'

class Potrace < Package
  description 'Potrace(TM) is a tool for tracing a bitmap, which means, transforming a bitmap into a smooth, scalable image.'
  homepage 'http://potrace.sourceforge.net/'
  version '1.16'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://potrace.sourceforge.net/download/1.16/potrace-1.16.tar.gz'
  source_sha256 'be8248a17dedd6ccbaab2fcc45835bb0502d062e40fbded3bc56028ce5eb7acc'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9b3c98c199a622153c6fc35ee284edab1dc872b6ab950983f26adee74f73dcb8',
     armv7l: '9b3c98c199a622153c6fc35ee284edab1dc872b6ab950983f26adee74f73dcb8',
       i686: 'd4b063df7f8db9488137a0e2c395bb10f249134c99e20fed86b094973825f0a4',
     x86_64: 'f740ee5ec834c0c43c58f4eee3015c286440368fd52e96c0cb6cafb8aeb5a77a'
  })

  depends_on 'glibc' # R
  depends_on 'zlibpkg' # R

  def self.build
    system "./configure #{CREW_OPTIONS} --with-libpotrace"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
