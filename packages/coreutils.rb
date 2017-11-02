require 'package'

class Coreutils < Package
  description 'The GNU Core Utilities are the basic file, shell and text manipulation utilities of the GNU operating system.'
  homepage 'http://www.gnu.org/software/coreutils/coreutils.html'
  version '8.28'
  source_url 'https://ftp.gnu.org/gnu/coreutils/coreutils-8.28.tar.xz'
  source_sha256 '1117b1a16039ddd84d51a9923948307cfa28c2cea03d1a2438742253df0a0c65'

  binary_url ({
  })
  binary_sha256 ({
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
