require 'package'

class Dpkg < Package
  description "dpkg is Debian's package management system."
  homepage 'https://salsa.debian.org/dpkg-team/dpkg/'
  version '1.20.7.1'
  compatibility 'all'
  source_url 'https://salsa.debian.org/dpkg-team/dpkg/-/archive/1.20.7.1/dpkg-1.20.7.1.tar.bz2'
  source_sha256 'a83444ecd04939143a87d8f4af612a9f089c75e881a8f12e5190d012325f6ab3'

  depends_on 'ncurses'
  depends_on 'libmd'
  depends_on 'xzutils'
  depends_on 'bz2'
  depends_on 'doxygen' => :build

  def self.build
    system "echo 1.20.7.1 >> .dist-version"
    system "./autogen"
    system "./configure #{CREW_OPTIONS} \
            --disable-update-alternatives \
            --disable-start-stop-daemon \
            --disable-dselect \
            --with-libmd"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end

  def self.postinstall
    puts
    puts 'dpkg is the Debian package manager'.lightblue
    puts 'This is useful for those who want to create/modify deb files'.lightblue
    puts 'However, do NOT use dpkg to install debs on your chromeos machine'.lightblue
    puts 'This may break your system; you may have to do a full recovery by USB'.lightblue
    puts "You've been warned!".lightblue
    puts
  end
end
