require 'package'

class Aircrack_ng < Package
  description 'Key cracker for the 802.11 WEP and WPA-PSK protocols.'
  homepage 'https://www.aircrack-ng.org'
  version '1.2-rc4-3'
  compatibility 'all'
  source_url 'http://download.aircrack-ng.org/aircrack-ng-1.2-rc4.tar.gz'
  source_sha256 'd93ac16aade5b4d37ab8cdf6ce4b855835096ccf83deb65ffdeff6d666eaff36'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aircrack_ng-1.2-rc4-3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aircrack_ng-1.2-rc4-3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aircrack_ng-1.2-rc4-3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aircrack_ng-1.2-rc4-3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6597d9d24115513c16113639a86f62fee44f6464d52ce9f18e782c9ca3ff97dd',
     armv7l: '6597d9d24115513c16113639a86f62fee44f6464d52ce9f18e782c9ca3ff97dd',
       i686: '52a3a53e68d690426018758cb0b5dbbe692b7ac70d0b42d0b198adb7010dbe42',
     x86_64: '8331f17911c1eac404a91eefd1a2673b4a2229f3c555155ca7622d534f59ca19',
  })

  depends_on 'bison' => :build
  depends_on 'flex' => :build
  depends_on 'libnl3'
  depends_on 'libpcap'
  depends_on 'sqlite'
  depends_on 'rfkill'
  depends_on 'zlibpkg'

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
