require 'package'

class Chicken < Package
  description 'CHICKEN is practical and portable scheme system.'
  homepage 'https://code.call-cc.org/'
  version '5.1.0'
  compatibility 'all'
  source_url 'https://code.call-cc.org/releases/5.1.0/chicken-5.1.0.tar.gz'
  source_sha256 '5c1101a8d8faabfd500ad69101e0c7c8bd826c68970f89c270640470e7b84b4b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/chicken-5.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/chicken-5.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/chicken-5.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/chicken-5.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '508dcf75c52f3d316a9479e593654a6db5fd8cfa54e874e673750f446a0ed8c4',
     armv7l: '508dcf75c52f3d316a9479e593654a6db5fd8cfa54e874e673750f446a0ed8c4',
       i686: '608ec4490b87f1b125d0577a2fc91bbc8a2d4031a4340307f7a8194ff73b2aa0',
     x86_64: '43218a8fdc1f7118dd93b3955da341c76b1689d1c29615eccb378beb450ae176',
  })

  depends_on 'filecmd'

  def self.build
    system "make", "-j1", "PLATFORM=linux" # parallel builds don't work
  end

  def self.install
    system "make", "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "install", "PLATFORM=linux"
  end
end
