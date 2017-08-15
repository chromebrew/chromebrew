require 'package'

class Vifm < Package
  description 'Vifm is an ncurses based file manager with vi like keybindings/modes/options/commands/configuration, which also borrows some useful ideas from mutt.'
  homepage 'https://vifm.info/'
  version '0.8.2'
  source_url 'https://downloads.sourceforge.net/project/vifm/vifm/vifm-0.8.2.tar.bz2'
  source_sha256 '8b466d766658a24d07fc2039a26fefc6a018f5653684a6035183ca79f02c211f'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/vifm-0.8.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/vifm-0.8.2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/vifm-0.8.2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/vifm-0.8.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd40d9b2183d4e6f80febbc92baf43dc51d8843653a86988e9dbcd8834fc0d54c',
     armv7l: 'd40d9b2183d4e6f80febbc92baf43dc51d8843653a86988e9dbcd8834fc0d54c',
       i686: '0bfec14d7486442fd2878619cf3915adef6a23a15a2d0ce524ec504a51e35d3f',
     x86_64: '4075037bc91bed7149b8cb4adfd5ca1688e88e971c6cf25d95df85531602b6b5',
  })

  depends_on 'ncurses'

  def self.build
    system "./configure", \
	   "--prefix=/usr/local", \
	   "--without-gtk", \
	   "--without-X11", \
	   #"--with-curses=/usr/local/include/ncursesw" \
	   #"--with-curses-name=ncursesw" \
	   "CPPFLAGS=-I/usr/local/include/ncursesw"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
