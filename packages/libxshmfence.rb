require 'package'

class Libxshmfence < Package
  description 'A library that exposes a event API on top of Linux futexes'
  homepage 'http://t2sde.org/packages/libxshmfence.html'
  version '1.2'
  source_url 'https://xorg.freedesktop.org/releases/individual/lib/libxshmfence-1.2.tar.bz2'
  source_sha256 'd21b2d1fd78c1efbe1f2c16dae1cb23f8fd231dcf891465b8debe636a9054b0c'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
