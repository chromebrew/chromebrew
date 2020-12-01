require 'package'

class Twm < Package
  description 'The twm package contains a very minimal window manager.'
  homepage 'http://www.linuxfromscratch.org/blfs/view/svn/x/twm.html'
  version '1.0.11'
  compatibility 'all'
  source_url 'https://www.x.org/pub/individual/app/twm-1.0.11.tar.xz'
  source_sha256 'f4e8a842dec410e79741f25ed4dfac09df080835d0bba2e3983b5914569b68c7'


  depends_on 'xorg_server'

  def self.build
    system "./configure  #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
