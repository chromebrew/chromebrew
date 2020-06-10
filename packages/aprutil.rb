require 'package'

class Aprutil < Package
  description 'APR-util provides a number of helpful abstractions on top of APR.'
  homepage 'http://apr.apache.org/'
  version '1.6.1'
  compatibility 'all'
  source_url 'https://apache.claz.org/apr/apr-util-1.6.1.tar.bz2'
  source_sha256 'd3e12f7b6ad12687572a3a39475545a072608f4ba03a6ce8a3778f607dd0035b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aprutil-1.6.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aprutil-1.6.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aprutil-1.6.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aprutil-1.6.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e9fc87b307ffd4b0ebf0f8edb198813eff40c78652ca128b870401e0b95e8da5',
     armv7l: 'e9fc87b307ffd4b0ebf0f8edb198813eff40c78652ca128b870401e0b95e8da5',
       i686: '487fce828c6a4e0bae45b4675240fa06bd7a59bde1007009db3722dce065397f',
     x86_64: 'e5abe47026a3bf51748e2d3aaaa1e5dc5d46c66180145502e989a28cdae49b30',
  })

  depends_on 'apr'
  depends_on 'expat'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--with-apr=#{CREW_PREFIX}",
           '--disable-maintainer-mode'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
