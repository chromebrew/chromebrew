require 'package'

class Cryptsetup < Package
  description 'Tool to setup encrypted devices with dm-crypt.'
  homepage 'https://gitlab.com/cryptsetup/cryptsetup/blob/master/README.md'
  version '2.0.2'
  source_url 'https://www.kernel.org/pub/linux/utils/cryptsetup/v2.0/cryptsetup-2.0.2.tar.xz'
  source_sha256 '4f8105d7f3bf758d58da3058b3cbd66c0ca81492b2dafe8ae7c049cc9e939e97'

  depends_on 'popt'
  depends_on 'libgpgerror'
  depends_on 'jsonc'
  depends_on 'util_linux'
  depends_on 'argon2'
  depends_on 'libgcrypt'
  depends_on 'nettle'
  depends_on 'openssl'
  depends_on 'lvm2'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end
