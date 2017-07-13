require 'package'

class Gperf < Package
  description 'GNU gperf is a perfect hash function generator.'
  homepage 'https://www.gnu.org/software/gperf/'
  version '3.1'
  source_url 'http://ftp.gnu.org/pub/gnu/gperf/gperf-3.1.tar.gz'
  source_sha256 '588546b945bba4b70b6a3a616e80b4ab466e3f33024a352fc2198112cdbb3ae2'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

