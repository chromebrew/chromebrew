require 'package'

class Clamav < Package
  description 'ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats.'
  homepage 'https://www.clamav.net/'
  version '0.103.0'
  compatibility 'all'
  source_url 'https://www.clamav.net/downloads/production/clamav-0.103.0.tar.gz'
  source_sha256 '32a9745277bfdda80e77ac9ca2f5990897418e9416880f3c31553ca673e80546'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system 'autoconf'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode',
           '--disable-zlib-vcheck'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
