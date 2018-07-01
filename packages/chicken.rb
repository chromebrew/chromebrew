require 'package'

class Chicken < Package
  description 'CHICKEN is practical and portable scheme system.'
  homepage 'https://code.call-cc.org/'
  version '4.13.0-1'
  source_url 'https://code.call-cc.org/releases/4.13.0/chicken-4.13.0.tar.gz'
  source_sha256 'add549619a31363d6608b39e0cf0e68b9d5e6ff2a719b5691ddeba57229c6c43'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/chicken-4.13.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/chicken-4.13.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/chicken-4.13.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/chicken-4.13.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8877684cca5b473a07bed10b722e823218056eb8e30d3c920d87c2f932145476',
     armv7l: '8877684cca5b473a07bed10b722e823218056eb8e30d3c920d87c2f932145476',
       i686: '3d1914f286e6c5d96cddbd7aadfeb9b327983218caebe3773c101a7c26bc9657',
     x86_64: 'ee8820ba71c1db4e90152cd52f133e2106292071b95d2bf6538b6e28aa723022',
  })

  depends_on 'filecmd'

  def self.build
    system "make", "PLATFORM=linux"
  end

  def self.install
    system "make", "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "install", "PLATFORM=linux"
  end
end
