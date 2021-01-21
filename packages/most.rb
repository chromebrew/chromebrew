require 'package'

class Most < Package
  description 'MOST is a powerful paging program for Unix, VMS, MSDOS, and win32 systems.'
  homepage 'http://www.jedsoft.org/most/'
  version '5.1.0'
  compatibility 'all'
  source_url 'https://www.jedsoft.org/releases/most/most-5.1.0.tar.gz'
  source_sha256 'db805d1ffad3e85890802061ac8c90e3c89e25afb184a794e03715a3ed190501'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/most-5.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/most-5.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/most-5.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/most-5.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '333fee656f76d9a8d5343edf9d2e1c29c48d73b4c21992a76439644c7edf7f70',
     armv7l: '333fee656f76d9a8d5343edf9d2e1c29c48d73b4c21992a76439644c7edf7f70',
       i686: '5e3463ae4c793fcc7ee528c0b722bfe665792f831e87e7d6b88c0a1bda124825',
     x86_64: '3fcf532ef15440abe83413ae0c422e480096a6b4997890eca2825ef288ed13ed',
  })

  depends_on 'slang'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
