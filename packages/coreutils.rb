require 'package'

class Coreutils < Package
  description 'The GNU Core Utilities are the basic file, shell and text manipulation utilities of the GNU operating system.'
  homepage 'http://www.gnu.org/software/coreutils/coreutils.html'
  version '8.28'
  source_url 'https://ftp.gnu.org/gnu/coreutils/coreutils-8.28.tar.xz'
  source_sha256 '1117b1a16039ddd84d51a9923948307cfa28c2cea03d1a2438742253df0a0c65'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/coreutils-8.28-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/coreutils-8.28-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/coreutils-8.28-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/coreutils-8.28-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6afe7164f0ab4a155561163a81076267bab1382ab753148d1fbc67de83a6f453',
     armv7l: '6afe7164f0ab4a155561163a81076267bab1382ab753148d1fbc67de83a6f453',
       i686: '235736810defe4992d8613429e636e60eccf3b7a914efc6d39061ccaaa466699',
     x86_64: 'd6fb89042cfb3558c24cb4d48977fb7bce334032014c2439ca62b035a3a47516',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    FileUtils.cd("#{CREW_DEST_PREFIX}/bin") do
      system "echo '#!/bin/bash' > arch"
      system "echo '#{CREW_PREFIX}/bin/uname -m' >> arch"
      system 'chmod +x arch'
    end
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
