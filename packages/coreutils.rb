require 'package'

class Coreutils < Package
  description 'The GNU Core Utilities are the basic file, shell and text manipulation utilities of the GNU operating system.'
  homepage 'http://www.gnu.org/software/coreutils/coreutils.html'
  @_ver = '8.32'
  version @_ver
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/gnu/coreutils/coreutils-#{@_ver}.tar.xz"
  source_sha256 '4458d8de7849df44ccab15e16b1548b285224dbba5f08fac070c1c0e0bcc4cfa'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/coreutils-8.32-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/coreutils-8.32-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/coreutils-8.32-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/coreutils-8.32-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'a1be275b2b5f26c724b73550c30a5e2e58c9267c2af853e660293d4e33138453',
      armv7l: 'a1be275b2b5f26c724b73550c30a5e2e58c9267c2af853e660293d4e33138453',
        i686: 'b45b19f985acb4429d6c0be54c8a60171afeac88c21cdac0434ab19475f815b3',
      x86_64: '1384d230561d78c1f87037a1422dfe04a4823bbbe5348370a319eb6c08e852a1',
  })

  def self.build
    system "env CFLAGS='-flto' ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    system "cat <<'EOF'> #{CREW_DEST_PREFIX}/bin/arch
#!/bin/bash
echo \"#{ARCH}\"
EOF"
    system "chmod +x #{CREW_DEST_PREFIX}/bin/arch"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
