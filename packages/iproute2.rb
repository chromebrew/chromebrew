require 'package'

class Iproute2 < Package
  description 'Iproute2 is a collection of utilities for controlling TCP / IP networking and traffic control in Linux.'
  homepage 'https://wiki.linuxfoundation.org/networking/iproute2'
  version '4.12.0'
  source_url 'https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-4.12.0.tar.xz'
  source_sha256 '2e0a4c4262d9f6c169885a6e16c4c5c5f1ef6fd57b6a0e7b41f42be5bb6ebd7d'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
