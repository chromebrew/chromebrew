require 'package'

class Busybox < Package
  description 'BusyBox is a software suite that provides several Unix utilities in a single executable file'
  homepage 'https://busybox.net'
  compatibility 'all'
  version '1.33.0'
  source_url 'https://www.busybox.net/downloads/busybox-1.33.0.tar.bz2'
  source_sha256 'd568681c91a85edc6710770cebc1e80e042ad74d305b5c2e6d57a5f3de3b8fbd'

  def self.patch
  end

  def self.build
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
