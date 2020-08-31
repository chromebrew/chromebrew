require 'package'

class Libnsutils < Package
  description 'CSS parser and selection engine, written in C'
  homepage 'https://www.netsurf-browser.org'
  version '0.1.0'
  compatibility 'all'
  source_url 'https://download.netsurf-browser.org/libs/releases/libnsutils-0.1.0-src.tar.gz'
  source_sha256 '790c6516344abe82f6289d656392e9ccebe475b20cc7e1e2d843011385f7aef0'

  def self.build
   system "make -j#{CREW_NPROC} PREFIX=#{CREW_PREFIX}"
  end
  def self.install
   system "make -j#{CREW_NPROC} DESTDIR=#{CREW_DEST_DIR} install PREFIX=#{CREW_PREFIX}"
  end
end
