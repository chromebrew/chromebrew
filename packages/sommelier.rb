require 'package'

class Sommelier < Package
  description 'Sommelier works by redirecting X11 and Wayland programs to the built-in ChromeOS wayland server.'
  homepage 'https://chromium.googlesource.com/chromiumos/containers/sommelier'
  version '0.20'
  source_url 'https://chromium.googlesource.com/chromiumos/containers/sommelier/+/0.20/README?format=TEXT'
  source_sha256 'b58d799b16d20abf92369fe0749c73f7398996f0afa9933517051778a8bb16c3'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'mesa'
  depends_on 'pixman'
  depends_on 'libxkbcommon'
  depends_on 'xwayland'
  depends_on 'libunwind'
  
  def self.build
    system 'mkdir sommelier'
    Dir.chdir ("sommelier") do
      system 'git clone https://chromium.googlesource.com/chromiumos/containers/sommelier -b 0.20 .'
      system 'sed -i "/sd_notify/d" sommelier.c'
      system 'sed -i "/sd-daemon/d" sommelier.c'
      system 'sed -i "s,libsystemd,,g" Makefile'
      system "sed -i 's,/lib/,/#{ARCH_LIB}/,g' Makefile"
      system "sed -i 's,-I.,-I. -I#{CREW_PREFIX}/include/pixman-1,g' Makefile"
      system "make PREFIX=#{CREW_PREFIX} SYSCONFDIR=#{CREW_PREFIX}/etc"
    end
  end

  def self.install
    Dir.chdir ("sommelier") do
      system "make", "PREFIX=#{CREW_PREFIX}", "SYSCONFDIR=#{CREW_PREFIX}/etc", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
