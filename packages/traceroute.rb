require 'package'

class Traceroute < Package
  description 'Traceroute tracks the route packets taken from an IP network on their way to a given host.'
  homepage 'http://traceroute.sourceforge.net/'
  version '2.1.0'
  source_url 'https://downloads.sourceforge.net/project/traceroute/traceroute/traceroute-2.1.0/traceroute-2.1.0.tar.gz'
  source_sha256 '3669d22a34d3f38ed50caba18cd525ba55c5c00d5465f2d20d7472e5d81603b6'

  def self.build
    # add /usr/lib64 to vpath to check /usr/lib64/libm.so
    system "sed", "-i", "Make.rules", "-e", "/vpath lib%.so/s:$: /usr/lib64:"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
