require 'package'

class Clamav < Package
  description 'ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats.'
  homepage 'https://www.clamav.net/'
  version '0.99.2'
  source_url 'https://www.clamav.net/downloads/production/clamav-0.99.2.tar.gz'
  source_sha1 'c1a47411834d8527f7b40727aebee63f01d488af'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
