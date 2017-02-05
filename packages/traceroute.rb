require 'package'

class Traceroute < Package
  version '2.1.0'
  source_url 'https://downloads.sourceforge.net/project/traceroute/traceroute/traceroute-2.1.0/traceroute-2.1.0.tar.gz'
  source_sha1 'bc5c6c8022187511be5665b3818d919be5987dcc'

  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
