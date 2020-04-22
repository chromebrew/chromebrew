require 'package'

class Hplip < Package
  description 'Print, Scan and Fax Drivers for Linux'
  homepage 'https://developers.hp.com/hp-linux-imaging-and-printing/'
  version '3.20.2'
  case ARCH
  when 'i686', 'x86_64'
    source_url 'https://sourceforge.net/projects/hplip/files/hplip/3.20.2/hplip-3.20.2.tar.gz'
    source_sha256 '90c49d74688b4d745a739a6db9bf8dbdfa134c24e921e31909bffe9d84f471c2'
  end

  binary_url ({
      i686: 'https://dl.bintray.com/chromebrew/chromebrew/hplip-3.20.2-chromeos-i686.tar.xz',
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/hplip-3.20.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
      i686: '3665d159fe1684d280689e09546a9f6cb0ab7be68d4e670f40c4111ae015d8b7',
    x86_64: '05b80f04ea8ac68ffad990ed86140932f6353d25f7fd116df5190e8484385f09',
  })

  depends_on 'cups'
  depends_on 'dbus'
  depends_on 'libjpeg_turbo'
  depends_on 'sane_backends'

  def self.patch
    system "curl -Ls -o config.guess 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD'"
    system "curl -Ls -o config.sub 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD'"
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,g' hpijs-drv"
    system "sed -i 's,/usr/include,#{CREW_PREFIX}/include,g' Makefile.in Makefile.am config.guess installer/core_install.py installer/dcheck.py"
    system 'sed -i "s,return(true);,return TRUE;,g" prnt/hpcups/genPCLm.cpp'
    system 'sed -i "s,return true;,return TRUE;,g" prnt/hpcups/genPCLm.cpp'
    system "sed -i 's,/usr/bin/file,#{CREW_PREFIX}/bin/file,g' configure"
  end

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-network-build"
    system 'make'
  end

  def self.install
    system "sed -i 's,/etc/sane.d,#{CREW_PREFIX}/etc/sane.d,g' Makefile"
    system "make DESTDIR=#{CREW_DEST_DIR} systraydir=#{CREW_PREFIX}/etc/xdg/autostart rulesdir=#{CREW_PREFIX}/etc/udev/rules.d hplip_confdir=#{CREW_PREFIX}/etc/hp cupsfilterdir=#{CREW_LIB_PREFIX}/cups/filter rulessystemdir=#{CREW_LIB_PREFIX}/systemd/system cupsbackenddir=#{CREW_LIB_PREFIX}/cups/backend mimedir=#{CREW_PREFIX}/share/cups/mime abs_mimedir=#{CREW_PREFIX}/share/cups/mime halpredir=#{CREW_PREFIX}/share/hal/fdi/preprobe/10osvendor icondir=#{CREW_PREFIX}/share/applications install"
  end
end
