require 'package'

class Httrack < Package
  description 'HTTrack is a free (GPL, libre/free software) and easy-to-use offline browser utility. It allows you to download a World Wide Web site from the Internet to a local directory, building recursively all directories, getting HTML, images, and other files from the server to your computer.'
  homepage 'http://www.httrack.com/'
  version '3.49.2'
  source_url 'http://mirror.httrack.com/httrack-3.49.2.tar.gz'
  source_sha256 '3477a0e5568e241c63c9899accbfcdb6aadef2812fcce0173688567b4c7d4025'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
