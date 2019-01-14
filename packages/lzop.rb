require 'package'

class Lzop < Package
  description 'lzop is a file compressor which is very similar to gzip.'
  homepage 'http://www.lzop.org/'
  version '1.04-1'
  source_url 'https://www.lzop.org/download/lzop-1.04.tar.gz'
  source_sha256 '7e72b62a8a60aff5200a047eea0773a8fb205caf7acbe1774d95147f305a2f41'

  binary_url ({
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lzop-1.04-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     x86_64: 'e690057fbe1ab77e71f9ee73bb0d5cd75a410f8f773869f75745622776b9dcaf',
  })

  depends_on 'lzo'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           '--disable-maintainer-mode',
           '--disable-dependency-tracking'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system 'make', 'check'
  end
end
