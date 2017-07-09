require 'package'

class Libpipeline < Package
  description 'libpipeline is a C library for manipulating pipelines of subprocesses in a flexible and convenient way.'
  homepage 'http://libpipeline.nongnu.org/'
  version '1.4.1-2'
  source_url 'https://download.savannah.gnu.org/releases/libpipeline/libpipeline-1.4.1.tar.gz'
  source_sha256 'da46d7b20163aadb9db2faae483f734e9096a7550c84b94029abeab62dd1b9ee'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libpipeline-1.4.1-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libpipeline-1.4.1-2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libpipeline-1.4.1-2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libpipeline-1.4.1-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0379c26755e40be724cecdcb1ac2799909531639d9bd25d89e2bad05e6e97101',
     armv7l: '0379c26755e40be724cecdcb1ac2799909531639d9bd25d89e2bad05e6e97101',
       i686: '1d8a76e13922f93fd8ba6cadb7745dba64b9df71f4e7cca661e72c9886a5f9a4',
     x86_64: 'e1e201410eece3e833fd0a63b7ed4a65c91f07d0212bd515ba68170678a1bca4',
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
