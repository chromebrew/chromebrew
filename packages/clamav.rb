require 'package'

class Clamav < Package
  description 'ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats.'
  homepage 'https://www.clamav.net/'
  version '0.103.0'
  compatibility 'all'
  source_url 'https://www.clamav.net/downloads/production/clamav-0.103.0.tar.gz'
  source_sha256 '32a9745277bfdda80e77ac9ca2f5990897418e9416880f3c31553ca673e80546'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/clamav-0.103.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/clamav-0.103.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/clamav-0.103.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/clamav-0.103.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c1bc0817863ee9f5e77e0805080cba457c405681b08960ff6581c5c1a39186fa',
     armv7l: 'c1bc0817863ee9f5e77e0805080cba457c405681b08960ff6581c5c1a39186fa',
       i686: '1f8fe38995c08b324d6ecab9e098ef9b7c5e0727b13986b3e5a2c1a023e5515e',
     x86_64: 'ad7996a0db5a870babab22074a874ca669f2922a245848683393adb2574ef402',
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
