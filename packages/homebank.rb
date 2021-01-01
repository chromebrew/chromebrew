require 'package'

class Homebank < Package
  description 'HomeBank is a free software that will assist you to manage your personal accounting.'
  homepage 'http://homebank.free.fr/en/index.php'
  version '5.4.3'
  compatibility 'all'
  source_url 'http://homebank.free.fr/public/homebank-5.4.3.tar.gz'
  source_sha256 '9222d7ed7cc44fcfff3f1fe20935a1b7fe91bb4d9f90003cb3c6f3b893298d0b'
  
  depends_on 'libofx'
  depends_on 'libsoup'
  depends_on 'gtk3'
  depends_on 'xdg_base'
  depends_on 'wayland_protocols'
  depends_on 'mesa'
  depends_on 'xcb_util'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
  def self.postinstall
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "echo 'alias bluefish=\"WAYLAND_DISPLAY=wayland-0 DISPLAY=\'\' GDK_BACKEND=wayland homebank\"' >> ~/.bashrc".lightblue
  end
end
