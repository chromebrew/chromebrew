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
     aarch64: 'dad8c4a7b6fe38114c099b0e1c7c7130a1f9bddfc80c8d56df978b3bb68e7250',
      armv7l: 'dad8c4a7b6fe38114c099b0e1c7c7130a1f9bddfc80c8d56df978b3bb68e7250',
        i686: 'e4b0c9478c2ffb15c7be9aa7219f7e4af334dd260363a497efdd6f5f8d2dfd9e',
      x86_64: 'd4eb950bb753789b837f9238fbd28cc8ea4e5e84f63a27b92ed676cb5fb418c4',
  })


  def self.build
    system "env CFLAGS='-flto' ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cd("#{CREW_DEST_PREFIX}/bin") do
      system "echo '#!/bin/bash' > arch"
      system "echo '#{ARCH}' >> arch"
      system 'chmod +x arch'
    end
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
