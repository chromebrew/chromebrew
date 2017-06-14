require "package"

class Gperf < Package
  description 'GNU gperf is a perfect hash function generator.'
  homepage 'https://www.gnu.org/software/gperf/'
  version "3.1"
  source_url "http://ftp.gnu.org/pub/gnu/gperf/gperf-3.1.tar.gz"
  source_sha1 "e3c0618c2d2e5586eda9498c867d5e4858a3b0e2"

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

