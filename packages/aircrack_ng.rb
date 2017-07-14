require 'package'

class Aircrack_ng < Package
  description 'Key cracker for the 802.11 WEP and WPA-PSK protocols.'
  homepage 'https://www.aircrack-ng.org'
  version '1.2-rc4'
  source_url 'http://download.aircrack-ng.org/aircrack-ng-1.2-rc4.tar.gz'
  source_sha256 'd93ac16aade5b4d37ab8cdf6ce4b855835096ccf83deb65ffdeff6d666eaff36'

  depends_on "buildessential" => :build
  depends_on "bison" => :build
  depends_on "flex" => :build
  depends_on "libnl3"
  depends_on "libpcap"
  depends_on "sqlite"
  depends_on "rfkill"

  def self.build
    system "make",
      "sqlite=true",
      "experimental=true"
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
