require 'package'

class Gtkvte < Package
  description 'The VTE package contains a termcap file implementation for terminal emulators.'
  homepage 'https://github.com/GNOME/vte'
  version '0.48.3'   # 0.48.3 is the stable version.  Version 0.51.x does not work
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/vte/0.48/vte-0.48.3.tar.xz'
  source_sha256 'a3a9fb182740b392a45cd3f46fa61a985f68bb6b1817b52daec22034c46158c3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtkvte-0.48.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtkvte-0.48.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtkvte-0.48.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtkvte-0.48.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '93f9d430e87dc5cf21aec88e4b32126ae0e16d272ebb4f220c4da57bd1e5d053',
     armv7l: '93f9d430e87dc5cf21aec88e4b32126ae0e16d272ebb4f220c4da57bd1e5d053',
       i686: '1a9026f4f4e3049a1b6de9eeed0ed5c67b4a91201074bb469ca09571d282269c',
     x86_64: '818b9ff560977cf9f2498c12174040ccb75cc67bbc92de227b1f57dbd0900ec2',
  })

  depends_on 'gtk3'
  depends_on 'pcre2'
  depends_on 'vala'
  depends_on 'six' => :build

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
