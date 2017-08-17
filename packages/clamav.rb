require 'package'

class Clamav < Package
  description 'ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats.'
  homepage 'https://www.clamav.net/'
  version '0.99.2-1'
  source_url 'https://www.clamav.net/downloads/production/clamav-0.99.2.tar.gz'
  source_sha256 '167bd6a13e05ece326b968fdb539b05c2ffcfef6018a274a10aeda85c2c0027a'

  depends_on 'patch'
  depends_on 'autoconf'

  def self.build
    # Apply patch available at https://bugzilla.clamav.net/show_bug.cgi?id=11711.
    # This will be fixed in next release.
    system "curl -L 'https://bugzilla.clamav.net/attachment.cgi?id=7207' | patch -p0"
    system "autoconf"
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
