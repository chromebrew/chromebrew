require 'package'

class Libogg < Package
  description 'Ogg is a multimedia container format, and the native file and stream format for the Xiph.org multimedia codecs.'
  homepage 'https://xiph.org/ogg/'
  version '1.3.1'
  source_url 'http://downloads.xiph.org/releases/ogg/libogg-1.3.1.tar.xz'
  source_sha256 '3a5bad78d81afb78908326d11761c0fb1a0662ee7150b6ad587cc586838cdcfa'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
