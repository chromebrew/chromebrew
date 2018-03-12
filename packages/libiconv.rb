require 'package'

class Libiconv < Package
  description 'GNU charset conversion library for libc which does not implement it.'
  homepage 'https://www.gnu.org/software/libiconv/'
  version '1.15'
  source_url 'https://ftpmirror.gnu.org/libiconv/libiconv-1.15.tar.gz'
  source_sha256 'ccf536620a45458d26ba83887a983b96827001e92a13847b45e4925cc8913178'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.15-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.15-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.15-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.15-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '047163a67f3ea9e143b465087d5ea4a3d17b963c8ad3579bc27a21934d4a17ab',
     armv7l: '047163a67f3ea9e143b465087d5ea4a3d17b963c8ad3579bc27a21934d4a17ab',
       i686: '28de005b59407d5343775296814e10272c53aedd860e0208f396cc873045c095',
     x86_64: '8689ee2b4acc0440df6eec9eb0fb19aa8393b68bd64517cbca65d98041a2c7cc',
  })
  
  depends_on 'glibc'
  depends_on 'manpages'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
end
