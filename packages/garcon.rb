require 'package'

class Garcon < Package
  description 'Glib/GIO freedesktop.org compliant menu implementation'
  homepage 'https://xfce.org/'
  version '0.7.0'
  compatibility 'all'
  source_url 'https://archive.xfce.org/src/xfce/garcon/0.7/garcon-0.7.0.tar.bz2'
  source_sha256 '82c3b61b508011642b09e6fb01b1d3f22c4e4de0fc54a9244327d0ddb66b2423'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/garcon-0.7.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/garcon-0.7.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/garcon-0.7.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/garcon-0.7.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b0259935006ca1549ba4bca6349047ccb730a4f6e0ae3bea71bb1ef84a46c032',
     armv7l: 'b0259935006ca1549ba4bca6349047ccb730a4f6e0ae3bea71bb1ef84a46c032',
       i686: 'cdbab26e79d8b12d9bdae3cdfbf02dd95488667748a79497c16484fd7b0b9fe6',
     x86_64: '4d4f409b680b69c1f0d45e8d49e99f559c53ce20bc4551e11b05a260933949bf',
  })

  depends_on 'gtk2'
  depends_on 'libxfce4ui'

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-static --enable-gtk2 --enable-libxfce4ui"
    system "make -j#{CREW_NPROC}"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
