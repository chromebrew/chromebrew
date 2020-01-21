require 'package'

class Gawk < Package
  description 'The gawk utility interprets a special-purpose programming language that makes it possible to handle simple data-reformatting jobs with just a few lines of code.'
  homepage 'https://www.gnu.org/software/gawk/'
  version '5.0.1'
  source_url 'https://ftpmirror.gnu.org/gawk/gawk-5.0.1.tar.xz'
  source_sha256 '8e4e86f04ed789648b66f757329743a0d6dfb5294c3b91b756a474f1ce05a794'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gawk-5.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gawk-5.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gawk-5.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gawk-5.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6d0fe32829c7f60400a11c727a01db6d2dcd6997f5180188fd0ff04f75f82758',
     armv7l: '6d0fe32829c7f60400a11c727a01db6d2dcd6997f5180188fd0ff04f75f82758',
       i686: 'a4d55290bf0bab116a6b8740b652d023dc66b6c86cb18a889decce7b257363c1',
     x86_64: 'cec79d580d52eca31927087cc1346fff08028edb3f9161106ca87719dd6b2350',
  })

  depends_on 'libsigsegv'
  depends_on 'readline' => :build
  depends_on 'ncurses'
  depends_on 'mpfr'
  depends_on 'gmp'

  def self.build
    system './configure', "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
