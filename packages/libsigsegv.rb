require 'package'

class Libsigsegv < Package
  description 'GNU libsigsegv is a library for handling page faults in user mode.'
  homepage 'https://www.gnu.org/software/libsigsegv/'
  version '2.13'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libsigsegv/libsigsegv-2.13.tar.gz'
  source_sha256 'be78ee4176b05f7c75ff03298d84874db90f4b6c9d5503f0da1226b3a3c48119'

  def self.build
    system 'autoreconf -fiv'
    # libsigsegv fails to build with LTO.
    system "#{CREW_ENV_FNO_LTO_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
