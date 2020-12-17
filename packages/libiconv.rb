require 'package'

class Libiconv < Package
  description 'GNU charset conversion library for libc which does not implement it.'
  homepage 'https://www.gnu.org/software/libiconv/'
  version '1.16-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libiconv/libiconv-1.16.tar.gz'
  source_sha256 'e6a1b1b589654277ee790cce3734f07876ac4ccfaecbee8afa0b649cf529cc04'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '653edc555a8a094bcee3bbd3ee8b4a88200c4f4e285df132bdaff4e3af6088cb',
     armv7l: '653edc555a8a094bcee3bbd3ee8b4a88200c4f4e285df132bdaff4e3af6088cb',
       i686: '2000fe80a1a2c85c117c0375a8826a3e0a9c7cb5353398847d5e04154c989f19',
     x86_64: '52e602f63df955c451b36ff0b204331ed5c336d384f6484b2f7d5ef7a43f2a6d',
  })

  def self.build
    system "./configure #{CREW_OPTIONS} --enable-static --enable-relocatable --enable-extra-encodings"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # Remove iconv.h which conflicts with same file from glibc
    FileUtils.rm "#{CREW_DEST_PREFIX}/include/iconv.h"
  end
end
