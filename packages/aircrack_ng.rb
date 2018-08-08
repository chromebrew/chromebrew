require 'package'

class Aircrack_ng < Package
  description 'Key cracker for the 802.11 WEP and WPA-PSK protocols.'
  homepage 'https://www.aircrack-ng.org'
  version '1.3'
  source_url 'https://download.aircrack-ng.org/aircrack-ng-1.3.tar.gz'
  source_sha256 '8ae08a7c28741f6ace2769267112053366550e7f746477081188ad38410383ca'

  binary_url ({
  })
  binary_sha256 ({
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
    system "./autogen.sh",
              "--prefix=#{CREW_PREFIX}",
              "--libdir=#{CREW_LIB_PREFIX}",
              "--with-experimental",
              "--with-ext-scripts",
              "--enable-shared",
              "--disable-static"
    system "TMPDIR=#{CREW_PREFIX}/tmp make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.postinstall
    system "sed -i 's,#{CREW_PREFIX},,' #{CREW_PREFIX}/sbin/airodump-ng-oui-update"
    system "sed -i 's,/etc,#{CREW_PREFIX}/etc,g' #{CREW_PREFIX}/sbin/airodump-ng-oui-update"
    system "sed -i 's,/usr/share,#{CREW_PREFIX}/share,' #{CREW_PREFIX}/sbin/airodump-ng-oui-update"
  end

  def self.check
    system "make", "check"
  end
end
