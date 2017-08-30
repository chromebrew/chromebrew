require 'package'

class Httrack < Package
  description 'HTTrack is a free (GPL, libre/free software) and easy-to-use offline browser utility. It allows you to download a World Wide Web site from the Internet to a local directory, building recursively all directories, getting HTML, images, and other files from the server to your computer.'
  homepage 'http://www.httrack.com/'
  version '3.49.2'
  source_url 'http://mirror.httrack.com/httrack-3.49.2.tar.gz'
  source_sha256 '3477a0e5568e241c63c9899accbfcdb6aadef2812fcce0173688567b4c7d4025'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/httrack-3.49.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/httrack-3.49.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/httrack-3.49.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/httrack-3.49.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6be1cdcfa09f5e26ef5474e259c73c124f7c7f7bd8d9e33bb8ad76bd4aac09a4',
     armv7l: '6be1cdcfa09f5e26ef5474e259c73c124f7c7f7bd8d9e33bb8ad76bd4aac09a4',
       i686: 'b420ef1c1cf0bb76f0cd9db8d5ecea083070fa401cb699eb228919b50db09b0a',
     x86_64: 'a76016c76644c3566f7b0ecbaf51aefd6a5855da9ac8f1297fbc2f1c56ce03c7',
  })

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
