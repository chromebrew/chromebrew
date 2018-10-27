require 'package'

class Dpkg < Package
  description 'A medium-level package manager for Debian'
  homepage 'https://anonscm.debian.org/git/dpkg/'
  version '1.19.2'
  source_url 'http://http.debian.net/debian/pool/main/d/dpkg/dpkg_1.19.2.tar.xz'
  source_sha256 'f8f2ae2cf8065b81239db960b3794099ec607c94a125cec61c986f68f9861b71'

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
