require 'package'

class Httrack < Package
  description 'HTTrack is a free (GPL, libre/free software) and easy-to-use offline browser utility. It allows you to download a World Wide Web site from the Internet to a local directory, building recursively all directories, getting HTML, images, and other files from the server to your computer.'
  homepage 'http://www.httrack.com/'
  version '3.49.2-1'
  compatibility 'all'
  source_url 'https://mirror.httrack.com/httrack-3.49.2.tar.gz'
  source_sha256 '3477a0e5568e241c63c9899accbfcdb6aadef2812fcce0173688567b4c7d4025'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/httrack-3.49.2-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/httrack-3.49.2-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/httrack-3.49.2-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/httrack-3.49.2-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '332ff037e21446d4bf593826221ce95895a6824ae2cb56d10bfff2e2827446c3',
     armv7l: '332ff037e21446d4bf593826221ce95895a6824ae2cb56d10bfff2e2827446c3',
       i686: '3e7799279a34e92db45e902bc478c0667c6b6623524d25c03556726012a99a52',
     x86_64: '2065795d69e14009464820aae2c13fad266e3be9c14243bf27a7c7f14f0eae0e',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
