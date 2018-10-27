require 'package'

class Dpkg < Package
  description 'A medium-level package manager for Debian'
  homepage 'https://anonscm.debian.org/git/dpkg/'
  version '1.19.2'
  source_url 'https://deb.debian.org/debian/pool/main/d/dpkg/dpkg_1.19.2.tar.xz'
  source_sha256 'f8f2ae2cf8065b81239db960b3794099ec607c94a125cec61c986f68f9861b71'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dpkg-1.19.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dpkg-1.19.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dpkg-1.19.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dpkg-1.19.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2fb0d2ada4de00332e73a4fabd754101ee21c3c23b1b9dffee4dd57ea4923228',
     armv7l: '2fb0d2ada4de00332e73a4fabd754101ee21c3c23b1b9dffee4dd57ea4923228',
       i686: '82386ba68f525549b60144dd00b7b3eea92ab59747138ec4351fedcf645a01f1',
     x86_64: 'ae5431150d307fc1cbf5635192bd6cb22f82d7fc60d3f7263b169dd4283205dd',
  })

  depends_on 'bz2'
  depends_on 'xzutils'

  def self.build
    system "/usr/bin/env",
           "PERL_LIBDIR=#{CREW_PREFIX}/lib/perl5/site_perl/",
           "./configure",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.preinstall
    if File.exists? "#{CREW_PREFIX}/var/lib/dpkg/status" then
      system "mv #{CREW_PREFIX}/var/lib/dpkg/status #{CREW_PREFIX}/var/lib/dpkg/status.old"
    end
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
    Dir.chdir ("#{CREW_DEST_PREFIX}/bin") do
      system 'mv dpkg dpkg-run'
      system "echo '#!/bin/bash' > dpkg"
      system "echo 'dpkg-run --force-not-root --force-depends \"$@\"' >> dpkg"
      system 'chmod a+x dpkg'
    end
  end

  def self.postinstall
    if File.exists? "#{CREW_PREFIX}/var/lib/dpkg/status.old" then
      system "mv #{CREW_PREFIX}/var/lib/dpkg/status.old #{CREW_PREFIX}/var/lib/dpkg/status"
    end
  end
end
