require 'package'

class Serf < Package
  description 'The serf library is a high performance C-based HTTP client library built upon the Apache Portable Runtime (APR) library.'
  homepage 'https://serf.apache.org/'
  version '1.3.9-2'
  compatibility 'all'
  source_url 'https://www.apache.org/dist/serf/serf-1.3.9.tar.bz2'
  source_sha256 '549c2d21c577a8a9c0450facb5cca809f26591f048e466552240947bdf7a87cc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/serf-1.3.9-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/serf-1.3.9-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/serf-1.3.9-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/serf-1.3.9-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd53554622ffbf45298ca579a698f0f9943cf96db6191e8c4967fc46bfea7900f',
     armv7l: 'd53554622ffbf45298ca579a698f0f9943cf96db6191e8c4967fc46bfea7900f',
       i686: '07de71d6b89e563ff00cce86302238a7174b913590e5aa9aaca272627a8314bd',
     x86_64: 'ca660768a60708d2c5acd2d88fa885dc23e302ce4b972d13e3ec585e94c1f1b2',
  })

  depends_on 'scons'
  depends_on 'aprutil'
  depends_on 'openssl'

  def self.build
    system "scons APR=#{CREW_PREFIX} APU=#{CREW_PREFIX} OPENSSL=#{CREW_PREFIX}/include/openssl PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "scons install --install-sandbox=#{CREW_DEST_DIR}"
  end
end
