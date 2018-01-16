require 'package'

class Coreutils < Package
  description 'The GNU Core Utilities are the basic file, shell and text manipulation utilities of the GNU operating system.'
  homepage 'http://www.gnu.org/software/coreutils/coreutils.html'
  version '8.29'
  source_url 'https://ftpmirror.gnu.org/gnu/coreutils/coreutils-8.29.tar.xz'
  source_sha256 '92d0fa1c311cacefa89853bdb53c62f4110cdfda3820346b59cbd098f40f955e'

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
