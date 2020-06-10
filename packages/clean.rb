require 'package'

class Clean < Package
  description 'Clean is a program that searches for files identified by regular expressions and deletes them'
  homepage 'https://sourceforge.net/projects/clean/'
  version '3.4'
  compatibility 'all'
  source_url 'http://downloads.sourceforge.net/project/clean/clean/3.4/clean-3.4.tar.bz2'
  source_sha256 '761f3a9e1ed50747b6a62a8113fa362a7cc74d359ac6e8e30ba6b30d59115320'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/clean-3.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/clean-3.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/clean-3.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/clean-3.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '151433790e60528adc37c9c80644269b5d57fdb5a2df0d0b79e99824245864e5',
     armv7l: '151433790e60528adc37c9c80644269b5d57fdb5a2df0d0b79e99824245864e5',
       i686: '10ef3b13c87579eb88ed3785fcaca37cf01f8ae607722c16fa7b64476971d2d2',
     x86_64: '6e74c2bf3f484265e016546d4e39300eea557744a7fd985b384e6c71d774512a',
  })

  def self.build
    system "make"
  end

  def self.install
    system "install -Dm755 -s clean #{CREW_DEST_PREFIX}/bin/clean"
    system "install -Dm644 clean.1 #{CREW_DEST_PREFIX}/share/man/man1/clean.1"
  end
end
