require 'package'

class Xcb_util_xrm < Package
  description 'XCB utility functions for the X resource manager'
  homepage 'https://github.com/Airblader/xcb-util-xrm'
  version '1.3'
  compatibility 'all'
  source_url 'https://github.com/Airblader/xcb-util-xrm/releases/download/v1.3/xcb-util-xrm-1.3.tar.bz2'
  source_sha256 '301cf33701207ea8782d49f4cb6404abd8f2d64e16f242017fd720be7c900c85'
  
  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
