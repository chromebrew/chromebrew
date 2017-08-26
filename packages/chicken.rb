require 'package'

class Chicken < Package
  description 'CHICKEN is practical and portable scheme system.'
  homepage 'https://code.call-cc.org/'
  version '4.12.0'
  source_url 'https://code.call-cc.org/releases/4.12.0/chicken-4.12.0.tar.gz'
  source_sha256 '605ace459bc66e8c5f82abb03d9b1c9ca36f1c2295931d244d03629a947a6989'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/chicken-4.12.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/chicken-4.12.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/chicken-4.12.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/chicken-4.12.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f7289dd5902762bbf0b4834a2167834d9ca09f688a1c6676dd5b9f27421beb1b',
     armv7l: 'f7289dd5902762bbf0b4834a2167834d9ca09f688a1c6676dd5b9f27421beb1b',
       i686: 'db922dce8a1ac59c223b2251e202add59b7d72e3c36bca5daf82d6e1943f4d64',
     x86_64: '2cc8acf02ac5d91c059664650a1886a67ec0ec4ce139d98f30560598d4fa165c',
  })

  def self.build
    system "make", "PLATFORM=linux"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install", "PLATFORM=linux"
  end
end
