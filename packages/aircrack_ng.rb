require 'package'

class Aircrack_ng < Package
  description 'Key cracker for the 802.11 WEP and WPA-PSK protocols.'
  homepage 'https://www.aircrack-ng.org'
  version '1.2-rc4-2'
  source_url 'http://download.aircrack-ng.org/aircrack-ng-1.2-rc4.tar.gz'
  source_sha256 'd93ac16aade5b4d37ab8cdf6ce4b855835096ccf83deb65ffdeff6d666eaff36'

  binary_url ({
  })
  binary_sha256 ({
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
    system "TMPDIR=#{CREW_PREFIX}/tmp make sqlite=true experimental=true"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}",
      "sqlite=true",
      "experimental=true",
      "prefix=#{CREW_PREFIX}",
      "libdir=#{CREW_LIB_PREFIX}",
      "bindir=#{CREW_PREFIX}/bin",
      "sbindir=#{CREW_PREFIX}/sbin",
      "mandir=#{CREW_PREFIX}/share/man/man1",
      "smandir=#{CREW_PREFIX}/share/man/man8",
      "install"
  end

  def self.postinstall
    # Fix for [*] Run 'airodump-ng-oui-update' as root (or with sudo) to install or update Airodump-ng OUI file (Internet connection required).
    #
    # Before fix:
    # $ sudo airodump-ng-oui-update
    # mkdir: cannot create directory '/etc/aircrack-ng': Read-only file system
    # [*] Downloading IEEE OUI file...
    # [*] Error: Failed to download OUI list, aborting...
    #
    # After fix:
    # $ sudo airodump-ng-oui-update
    # [*] Downloading IEEE OUI file...
    # [*] Parsing OUI file...
    # [*] Airodump-ng OUI file successfully updated
    system "sed -i 's,/usr/local,,' #{CREW_PREFIX}/sbin/airodump-ng-oui-update"
    system "sed -i 's,/etc,#{CREW_PREFIX}/etc,g' #{CREW_PREFIX}/sbin/airodump-ng-oui-update"
    system "sed -i 's,/usr/share,#{CREW_PREFIX}/share,' #{CREW_PREFIX}/sbin/airodump-ng-oui-update"
  end

  def self.check
    system "make",
      "sqlite=true",
      "experimental=true",
      "check"
  end
end
