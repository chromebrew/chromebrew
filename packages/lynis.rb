require 'package'

class Lynis < Package
  description 'Lynis is a security auditing tool for UNIX derivatives like Linux, macOS, BSD, Solaris, AIX, and others.'
  homepage 'https://cisofy.com/download/lynis/'
  version '3.0.1'
  compatibility 'all'
  source_url 'https://downloads.cisofy.com/lynis/lynis-3.0.1.tar.gz'
  source_sha256 '8381b62e11a5e0ead417bcfd92845adab7dc3b9d06271c852a1166cb65a61aff'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lynis-3.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lynis-3.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lynis-3.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lynis-3.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4172f481e0e7fec75b0c5e7552a3cd6f22a4f6aed883bf8c08d3670216617f6b',
     armv7l: '4172f481e0e7fec75b0c5e7552a3cd6f22a4f6aed883bf8c08d3670216617f6b',
       i686: '9e3335b473b1b978c5c237a5866471220bf7024287c44735249be7a2d9f2094d',
     x86_64: '73aa5996210bb14aca743a9a58bb8169fb377c1e9b19ac1e542484b11a86f260',
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/man/man8"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/lynis"
    system "gzip -9 lynis.8"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/lynis"
    system "echo '#!/bin/bash' > lynis"
    system "echo 'PWD=\$(pwd)' >> lynis"
    system "echo 'cd #{CREW_PREFIX}/share/lynis' >> lynis"
    system "echo './lynis \"\$@\"' >> lynis"
    system "echo 'cd \$PWD' >> lynis"
    system "install -Dm755 lynis #{CREW_DEST_PREFIX}/bin/lynis"
    system "install -Dm644 lynis.8.gz #{CREW_DEST_PREFIX}/man/man8/lynis.8.gz"
  end
end
