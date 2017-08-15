require 'package'

class Libogg < Package
  description 'Ogg is a multimedia container format, and the native file and stream format for the Xiph.org multimedia codecs.'
  homepage 'https://xiph.org/ogg/'
  version '1.3.1'
  source_url 'http://downloads.xiph.org/releases/ogg/libogg-1.3.1.tar.xz'
  source_sha256 '3a5bad78d81afb78908326d11761c0fb1a0662ee7150b6ad587cc586838cdcfa'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libogg-1.3.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libogg-1.3.1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libogg-1.3.1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libogg-1.3.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '34edf43684dc3fe1df6230bf109ff47173f4e303287b7f0c9d7364e44bf049d4',
     armv7l: '34edf43684dc3fe1df6230bf109ff47173f4e303287b7f0c9d7364e44bf049d4',
       i686: 'b9b1ee953642cf9c3bbd364484c74f87c987814e9f222e50df80e786328ef808',
     x86_64: 'bcb765c7e87300dff0769fb12eab2b1b3fc2f8f788b91adf22ca3c089bbe14ae',
  })

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
