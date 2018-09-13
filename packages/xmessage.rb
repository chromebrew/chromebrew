require 'package'

class Xmessage < Package
  description 'Xmessage displays a message or query in a window.'
  homepage 'https://www.x.org/archive/X11R6.9.0/doc/html/xmessage.1.html'
  version '1.0.5'
  source_url 'https://www.x.org/releases/individual/app/xmessage-1.0.5.tar.bz2'
  source_sha256 '373dfb81e7a6f06d3d22485a12fcde6e255d58c6dee1bbaeb00c7d0caa9b2029'

  depends_on 'xorg_lib'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
