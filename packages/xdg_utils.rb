require 'package'

class Xdg_utils < Package
  description 'xdg-utils is a set of tools that allows applications to easily integrate with the desktop environment of the user, regardless of the specific desktop environment that the user runs.'
  homepage 'https://www.freedesktop.org/wiki/Software/xdg-utils/'
  version '1.1.3'
  source_url 'https://portland.freedesktop.org/download/xdg-utils-1.1.3.tar.gz'
  source_sha256 'd798b08af8a8e2063ddde6c9fa3398ca81484f27dec642c5627ffcaa0d4051d9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xdg_utils-1.1.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xdg_utils-1.1.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xdg_utils-1.1.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xdg_utils-1.1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '047179b2eed1133b4694e22ccf3bdec32840162ec267db88e7f2b4f72b7cb757',
     armv7l: '047179b2eed1133b4694e22ccf3bdec32840162ec267db88e7f2b4f72b7cb757',
       i686: '4e362f4e1f5d0425b8f51188bf2800125cd7e8c395bbb41f529111a6c8795235',
     x86_64: '2cf6a0564337993c470a8fcbaf9a9f588a0b1171ddd8fcfe42d3568625bca7b4',
  })

  depends_on 'help2man' => :build

  def self.build
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/man/man1"
    system "./configure --prefix=#{CREW_PREFIX}"
    system "sed -i 's,html man scripts,scripts,' scripts/Makefile"
    system "sed -i '65,71d' scripts/Makefile"
    system "sed -i '63imv \$\$x.in \$\$x; \\\\' scripts/Makefile"
    system "sed -i '64ihelp2man -N --no-discard-stderr \$\$x > \$\$x.1; \\\\' scripts/Makefile"
    system "sed -i '65igzip -9 \$\$x.1; \\\\' scripts/Makefile"
    system "sed -i '66iinstall -Dm755 \$\$x.1.gz #{CREW_DEST_PREFIX}/share/man/man1/\$\$x.1.gz; \\\\' scripts/Makefile"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
