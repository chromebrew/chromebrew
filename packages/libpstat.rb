require 'package'

class Libpstat < Package
  description 'Library for getting information about running processes'
  homepage 'https://github.com/jcnelson/libpstat'
  version '030f37'
  source_url 'https://github.com/jcnelson/libpstat/archive/030f37a9d22ef3b8be839d487c97759e6126c30f.tar.gz'
  source_sha256 '71e5d3f190fe045b38f31dfa9b5962fb6ea4099f46b25981b411122569ff6b30'

  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
