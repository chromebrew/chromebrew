require 'package'

class Hplip < Package
  description 'Print, Scan and Fax Drivers for Linux'
  homepage 'https://developers.hp.com/hp-linux-imaging-and-printing/'
  version '3.23.12'
  license 'GPL-2'
  compatibility 'i686,x86_64'
  source_url 'https://sourceforge.net/projects/hplip/files/hplip/3.23.12/hplip-3.23.12.tar.gz'
  source_sha256 'a76c2ac8deb31ddb5f0da31398d25ac57440928a0692dcb060a48daa718e69ed'
  binary_compression 'tar.zst'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/hplip/3.23.12_x86_64/hplip-3.23.12-chromeos-x86_64.tar.zst',
      i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/hplip/3.23.12_i686/hplip-3.23.12-chromeos-i686.tar.zst'
  })
  binary_sha256({
    x86_64: '6776701484130b500892959a852ce9a8c8ea8054974d64ce4539c00af64d645f',
      i686: '21e9b1238a06179554894a61c8a0e7505e25d4259d798160a500c92c37661c95'
  })

  depends_on 'cups'
  depends_on 'dbus'
  depends_on 'libjpeg'
  depends_on 'sane_backends'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libusb' # R
  depends_on 'zlibpkg' # R

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
