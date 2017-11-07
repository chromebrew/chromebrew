require 'package'

class Aircrack_ng < Package
  description 'Key cracker for the 802.11 WEP and WPA-PSK protocols.'
  homepage 'https://www.aircrack-ng.org'
  version '1.2-rc4-1'
  source_url 'http://download.aircrack-ng.org/aircrack-ng-1.2-rc4.tar.gz'
  source_sha256 'd93ac16aade5b4d37ab8cdf6ce4b855835096ccf83deb65ffdeff6d666eaff36'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aircrack_ng-1.2-rc4-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aircrack_ng-1.2-rc4-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aircrack_ng-1.2-rc4-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aircrack_ng-1.2-rc4-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '107208b355883f2ba93284f37b5e07b0db423d8f601f16bb2f3b21a7e7d2c9c1',
     armv7l: '107208b355883f2ba93284f37b5e07b0db423d8f601f16bb2f3b21a7e7d2c9c1',
       i686: '4d2d0a09ef761fc41253ae03c0d8476ee46d0d1383ac922d217c3dd8ad319034',
     x86_64: '46b458a3d128c404c8eaaad4dd00feaed9aacac531406983bf7fb13cb37d7baa',
  })

  depends_on "buildessential" => :build
  depends_on "bison" => :build
  depends_on "flex" => :build
  depends_on "libnl3"
  depends_on "libpcap"
  depends_on "sqlite"
  depends_on "rfkill"

  def self.build
    # Need to specify TMPDIR to run automatic configuration tool correctly
    system "TMPDIR=/usr/local/tmp make sqlite=true experimental=true"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}",
      "sqlite=true",
      "experimental=true",
      "bindir=/usr/local/bin",
      "sbindir=/usr/local/sbin",
      "mandir=/usr/local/share/man/man1",
      "smandir=/usr/local/share/man/man8",
      "install"
  end

  def self.check
    system "make",
      "sqlite=true",
      "experimental=true",
      "check"
  end
end
