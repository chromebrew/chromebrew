require 'package'

class Aircrack_ng < Package
  description 'Key cracker for the 802.11 WEP and WPA-PSK protocols.'
  homepage 'https://www.aircrack-ng.org'
  version '1.6-17f9'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/aircrack-ng/aircrack-ng/archive/17f971cebdaeea0c86e338bde09a52787fcd6d9c.zip'
  source_sha256 'd6dc9078f2ab56671f8fb707aa5ddbbec36d1a732cc7ad9a3d2803a5dbbaae5b'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/aircrack_ng/1.6-17f9_armv7l/aircrack_ng-1.6-17f9-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/aircrack_ng/1.6-17f9_armv7l/aircrack_ng-1.6-17f9-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/aircrack_ng/1.6-17f9_i686/aircrack_ng-1.6-17f9-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/aircrack_ng/1.6-17f9_x86_64/aircrack_ng-1.6-17f9-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '5e48972faf181388c35a818ecfd5057b384752e82aab190376acbf838be7ee88',
     armv7l: '5e48972faf181388c35a818ecfd5057b384752e82aab190376acbf838be7ee88',
       i686: 'e3a7f24e822efc47f0402993ca482c5e4eae75cb49e6912eda44dcc52bbc2e81',
     x86_64: '5c7cfe8e71c1dc3f5634027855ebee88d458a08f44bca3ed0a01388f0524524c'
  })

  depends_on 'libnl3'
  depends_on 'libpcap'
  depends_on 'rfkill'

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    # system "./configure --help"
    # Could also add more specific optimization options:
    # --with-static-simd[=x86-sse2|x86-avx|x86-avx2|x86-avx512|ppc-altivec|ppc-power8|arm-neon|arm-asimd],
    # use specific SIMD implementation at static link, [default=none]
    # --with-avx512[=yes|no]  use AVX-512F instruction set, [default=no]
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS} \
      --program-prefix='' --program-suffix='' \
      --with-lto \
      --with-experimental=yes \
      --with-openssl=#{CREW_PREFIX} \
      sbindir=#{CREW_PREFIX}/sbin \
      mandir=#{CREW_PREFIX}/share/man/man1 \
      smandir=#{CREW_PREFIX}/share/man/man8"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}",
           'install'
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
    system "sed -i 's,/usr/local,,' #{CREW_DEST_PREFIX}/sbin/airodump-ng-oui-update"
    system "sed -i 's,/etc,#{CREW_PREFIX}/etc,g' #{CREW_DEST_PREFIX}/sbin/airodump-ng-oui-update"
    system "sed -i 's,/usr/share,#{CREW_PREFIX}/share,' #{CREW_DEST_PREFIX}/sbin/airodump-ng-oui-update"
  end

  def self.check
    system 'make',
           'sqlite=true',
           'experimental=true',
           'check'
  end
end
