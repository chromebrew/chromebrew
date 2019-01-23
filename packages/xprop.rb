require 'package'

class Xprop < Package
  description 'Xprop is a property displayer for X.'
  homepage 'https://www.x.org/'
  version '1.2.3'
  source_url 'https://x.org/releases/individual/app/xprop-1.2.3.tar.bz2'
  source_sha256 'd22afb28c86d85fff10a50156a7d0fa930c80ae865d70b26d805fd28a17a521b'

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
