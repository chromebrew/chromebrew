require 'package'

class Clamav < Package
  description 'ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats.'
  homepage 'https://www.clamav.net/'
  version '0.99.2'
  source_url 'https://www.clamav.net/downloads/production/clamav-0.99.2.tar.gz'
  source_sha256 '167bd6a13e05ece326b968fdb539b05c2ffcfef6018a274a10aeda85c2c0027a'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
