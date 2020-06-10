require 'package'

class Vifm < Package
  description 'Vifm is an ncurses based file manager with vi like keybindings/modes/options/commands/configuration, which also borrows some useful ideas from mutt.'
  homepage 'https://vifm.info/'
  version '0.9'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/vifm/vifm/vifm-0.9.tar.bz2'
  source_sha256 'ab10c99d1e4c24ff8a03c20be1c202cc15874750cc47a1614e6fe4f8d816a7fd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vifm-0.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vifm-0.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vifm-0.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vifm-0.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '78e4257894e5c19e825d6b33d2f66fc29189bd17bbfa21aa8eecb9b4b75c47da',
     armv7l: '78e4257894e5c19e825d6b33d2f66fc29189bd17bbfa21aa8eecb9b4b75c47da',
       i686: '3611f9a8b5740242b672b9c91efca3c537a63c2fbfb0d3ab9f4f3b1e5a91b701',
     x86_64: 'bf9c7b3328428b50247c9ae6d5386f055357a8f6919efc03174666440b1b923e',
  })

  def self.build
    system "./configure", \
	   "--prefix=#{CREW_PREFIX}", \
	   "--without-gtk", \
	   "--without-X11", \
	   #"--with-curses=#{CREW_PREFIX}/include/ncursesw" \
	   #"--with-curses-name=ncursesw" \
	   "CPPFLAGS=-I#{CREW_PREFIX}/include/ncursesw"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
