require 'package'

class Libpipeline < Package
  description 'libpipeline is a C library for manipulating pipelines of subprocesses in a flexible and convenient way.'
  homepage 'http://libpipeline.nongnu.org/'

  version '1.4.2'
  source_url 'https://download.savannah.gnu.org/releases/libpipeline/libpipeline-1.4.2.tar.gz'
  source_sha256 'fef1fc9aa40ce8796f18cd1aecd888a9484a9556c8b0f8d07c863578277679be'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libpipeline-1.4.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libpipeline-1.4.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libpipeline-1.4.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libpipeline-1.4.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5094a4df0e8eedce62fa401b182a7e800d5fbc11dbc17bc412bed376de6ad12a',
     armv7l: '5094a4df0e8eedce62fa401b182a7e800d5fbc11dbc17bc412bed376de6ad12a',
       i686: 'a3557d35b55bc238be7de5dc70d559194a463069fc7e405da7247f62dbf62e83',
     x86_64: '628776afa460b3c5ffd73ae8af404beb88b13c620b2bd25d08abc197190d7519',
  })

  def self.build
    system './configure', "--libdir=#{CREW_LIB_PREFIX}", '--disable-static', '--enable-shared', '--with-pic'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
