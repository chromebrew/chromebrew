require 'package'

class Testdisk < Package
  description 'TestDisk is powerful free data recovery software!'
  homepage 'https://www.cgsecurity.org/wiki/TestDisk'
  version '7.2-1'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://www.cgsecurity.org/testdisk-7.2-WIP.tar.bz2'
  source_sha256 '501df617fe1541d66c34fc6337dfc8b76f3e862ce55e3d19ccb3e29ced430f57'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '02481100433190d98338035d8f5261500859bc748994f77c3bf5c2a80d9fea68',
     armv7l: '02481100433190d98338035d8f5261500859bc748994f77c3bf5c2a80d9fea68',
       i686: 'cbd898f11ef7c5338f59c85b1b75b88fb24aaf26f23f8b1dc62dcdb1c77f0e7c',
     x86_64: 'c861cb658e05fee9728239a404f4aaf87617fb19805f9ec2f183f6a9ff6205db'
  })

  depends_on 'apr_iconv'
  depends_on 'compressdoc' => :build
  depends_on 'libjpeg'
  depends_on 'ncurses'
  depends_on 'zlibpkg'
  depends_on 'e2fsprogs' # R
  depends_on 'glibc' # R
  depends_on 'util_linux' # R

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
