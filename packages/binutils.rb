require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools.'
  homepage 'http://www.gnu.org/software/binutils/'
  version '2.30'
  source_url 'https://ftpmirror.gnu.org/binutils/binutils-2.30.tar.xz'
  source_sha256 '6e46b8aeae2f727a36f0bd9505e405768a72218f1796f0d09757d45209871ae6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.30-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.30-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.30-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.30-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cf68c98c124da6a4c562a9e65a4b34affbcb48e522c3547d44f8adcaa175be8b',
     armv7l: 'cf68c98c124da6a4c562a9e65a4b34affbcb48e522c3547d44f8adcaa175be8b',
       i686: '6798d0bc77d69db1e8a43b0dac0e0c5f76fa42b0108fe4ad93ac09d48d601ab1',
     x86_64: '9ebfc96ab4e762b7c7804cdd282adcce3077dc5fd0b020a2f6337d12f012b934',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
