require 'package'

class Xclock < Package
  description 'The xclock package contains a simple clock application which is used in the default xinit configuration.'
  homepage 'https://www.x.org/archive/X11R6.8.1/doc/xclock.1.html'
  version '1.0.9'
  compatibility 'all'
  source_url 'https://www.x.org/pub/individual/app/xclock-1.0.9.tar.bz2'
  source_sha256 'cf461fb2c6f2ac42c54d8429ee2010fdb9a1442a370adfbfe8a7bfaf33c123bb'


  depends_on 'xorg_lib'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
