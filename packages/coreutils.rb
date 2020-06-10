require 'package'

class Coreutils < Package
  description 'The GNU Core Utilities are the basic file, shell and text manipulation utilities of the GNU operating system.'
  homepage 'http://www.gnu.org/software/coreutils/coreutils.html'
  version '8.29'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/coreutils/coreutils-8.29.tar.xz'
  source_sha256 '92d0fa1c311cacefa89853bdb53c62f4110cdfda3820346b59cbd098f40f955e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/coreutils-8.29-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/coreutils-8.29-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/coreutils-8.29-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/coreutils-8.29-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cc4f7ac351c1de16e6dd195c795b3505f05fc981bae46d0ab7cfbc7009ee920d',
     armv7l: 'cc4f7ac351c1de16e6dd195c795b3505f05fc981bae46d0ab7cfbc7009ee920d',
       i686: 'c55c8f37354f348741f387fe0de01f664dfe20ad89e8ae93b27d66553375add9',
     x86_64: '26c43836ce9581f9daeddc1b50f88a88d5c1f8417cd545ee417729f94ad59621',
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
