require 'package'

class Patchelf < Package
  version '0.8-2'
  source_url 'http://nixos.org/releases/patchelf/patchelf-0.8/patchelf-0.8.tar.bz2'
  source_sha1 'd0645e9cee6f8e583ae927311c7ce88d29f416fc'

  def self.build
    system "./configure", "prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
