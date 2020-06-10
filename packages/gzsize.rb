require 'package'

class Gzsize < Package
  description 'Print the uncompressed size of a GZipped file.'
  homepage 'https://bfontaine.github.io/gzsize/'
  version '0.1.1'
  compatibility 'all'
  source_url 'https://github.com/bfontaine/gzsize/archive/0.1.1.tar.gz'
  source_sha256 'ffb9cc1e5ed10443b1bcf2f711787bc7f69eee27ed83b48f2ccf9d80e39554dd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gzsize-0.1.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gzsize-0.1.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gzsize-0.1.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gzsize-0.1.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd4a24b086e172b771b389d5ce421877e5c3763dc66731cbbfa3bfe2fc40b66c6',
     armv7l: 'd4a24b086e172b771b389d5ce421877e5c3763dc66731cbbfa3bfe2fc40b66c6',
       i686: 'e8bbc0b2342a40b5c6cb231d61425a78e2804df614bd34bfe37ffc0cb2659c84',
     x86_64: '5da9324de5a8799dad4cc5126033eefbed40aeb5c2e5616aede325010f500b91',
  })

  def self.build
    system "make"
  end

  def self.install
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/bin"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/man/man1"
    FileUtils.cp "gzsize", "#{CREW_DEST_PREFIX}/bin/gzsize"
    FileUtils.cp "man/gzsize.1", "#{CREW_DEST_PREFIX}/man/man1/gzsize.1"
  end
end
