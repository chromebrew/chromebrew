require 'package'

class Traceroute < Package
  description 'Traceroute tracks the route packets taken from an IP network on their way to a given host.'
  homepage 'http://traceroute.sourceforge.net/'
  version '2.1.0'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/traceroute/traceroute/traceroute-2.1.0/traceroute-2.1.0.tar.gz'
  source_sha256 '3669d22a34d3f38ed50caba18cd525ba55c5c00d5465f2d20d7472e5d81603b6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/traceroute-2.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/traceroute-2.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/traceroute-2.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/traceroute-2.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4342a2b6b38304f358664cacb75c9d97bf1eb284cd7f000087b62699bfebc835',
     armv7l: '4342a2b6b38304f358664cacb75c9d97bf1eb284cd7f000087b62699bfebc835',
       i686: '736d285cddf4ca0263228fd2b121cc568e4abb97040498edeb26ace1b1e17288',
     x86_64: 'db706290793033ec37f81c512f914f101fd4c36df7bc8e48e03f0f19ea2f5b6e',
  })

  def self.build
    # add /usr/lib64 to vpath to check /usr/lib64/libm.so
    system "sed", "-i", "Make.rules", "-e", "/vpath lib%.so/s:$: /usr/lib64:"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
