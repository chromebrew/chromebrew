require 'package'

class Libva < Package
  description 'Libva is an implementation for VA-API (VIdeo Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  version '2.3.0'
  source_url 'https://github.com/intel/libva/releases/download/2.3.0/libva-2.3.0.tar.bz2'
  source_sha256 '60840e50da6932ee2111e15fc8911180ff8a0d6f18bb9cc6ba8c1030098fdce4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.3.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.3.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.3.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.3.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '867f6254b17be1fa9fec487767d559b097577ff7984efed98bb9c81af2190552',
     armv7l: '867f6254b17be1fa9fec487767d559b097577ff7984efed98bb9c81af2190552',
       i686: 'b517990ffb952a847de93c2fe9ba9221776bb26e83218e82dfdb86f4ab3ea972',
     x86_64: '2bb0f970dc79c3f4a1046f6b1ef6b30c2bd10e3b5a86d17efdb5eb1ac35f2dbf',
  })

  depends_on 'libdrm'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
