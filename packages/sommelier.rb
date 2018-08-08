require 'package'

class Sommelier < Package
  description 'Sommelier works by redirecting X11 and Wayland programs to the built-in ChromeOS wayland server.'
  homepage 'https://chromium.googlesource.com/chromiumos/containers/sommelier'
  version 'f85b7e1'
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
  depends_on 'xkbcomp'
  
  def self.build
    system 'mkdir sommelier'
    system 'git clone https://chromium.googlesource.com/chromiumos/containers/sommelier -b f85b7e1ca4882c63467c7b3ec2ee65c654eca0d0'
    Dir.chdir ("sommelier") do
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
