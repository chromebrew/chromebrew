require 'package'

class Axel < Package
  description 'Light command line download accelerator for Linux and Unix'
  homepage 'https://github.com/axel-download-accelerator/axel'
  version '2.16.1'
  source_url 'https://github.com/axel-download-accelerator/axel/releases/download/v2.16.1/axel-2.16.1.tar.xz'
  source_sha256 'd34094eb63eaebc989f96eabdda091dcfb28e840bb8d274a5f216775941f59e4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/axel-2.16.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/axel-2.16.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/axel-2.16.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/axel-2.16.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '823600341cf335d42a3e23465d693925e1b03af01aa974f52e3ca66659c0e91b',
     armv7l: '823600341cf335d42a3e23465d693925e1b03af01aa974f52e3ca66659c0e91b',
       i686: '2f3807501995381c3c60beff7eb30bc007337a7f28fc0fd244aea9a3a046fc72',
     x86_64: '842d5fee9613e55a6efc696739814a623d77b16494d2bf7c6d473aa5b686530c',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
