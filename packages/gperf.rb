require "package"

class Gperf < Package
  version "3.0.4"
  source_url "http://ftp.gnu.org/pub/gnu/gperf/gperf-3.0.4.tar.gz"
  source_sha1 "e32d4aff8f0c730c9a56554377b2c6d82d0951b8"

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

