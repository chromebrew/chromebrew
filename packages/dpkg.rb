require 'package'

class Dpkg < Package
  description 'A medium-level package manager for Debian'
  homepage 'https://anonscm.debian.org/git/dpkg/'
  version '1.18.25-1'
  source_url 'https://salsa.debian.org/dpkg-team/dpkg/-/archive/1.18.25/dpkg-1.18.25.tar.gz'
  source_sha256 '93470770161bb15fd7988da1890aecda322e19c3fc858d6cb8f33417e5fe01e9'

  depends_on 'bz2'
  depends_on 'xzutils'
  depends_on 'fakeroot'

  def self.build
    system "git clone https://salsa.debian.org/dpkg-team/dpkg.git -b 1.18.25"
    Dir.chdir ("dpkg") do
      system "autoreconf -i -f"
      system "./configure --libdir=#{CREW_LIB_PREFIX} --prefix=#{CREW_PREFIX}"
      system "make"
    end
  end

  def self.preinstall
    if File.exists? "#{CREW_PREFIX}/var/lib/dpkg/status" then
      system "mv #{CREW_PREFIX}/var/lib/dpkg/status #{CREW_PREFIX}/var/lib/dpkg/status.old"
    end
  end

  def self.install
    Dir.chdir ("dpkg") do
      system "make install DESTDIR=#{CREW_DEST_DIR}"
      system "mkdir -p #{CREW_DEST_PREFIX}/usr/"
      system "cp -rpa #{CREW_PREFIX}/usr/. #{CREW_PREFIX} || true"
      system "cp -rpa #{CREW_PREFIX}/local/. #{CREW_PREFIX} || true"
      system "rm -rf #{CREW_PREFIX}/usr #{CREW_PREFIX}/local"
      system "ln -s #{CREW_DEST_PREFIX}/usr ."
      system "ln -s #{CREW_DEST_PREFIX}/local ."
      system "mkdir -p #{CREW_DEST_PREFIX}/var/lib/dpkg/"
      system "touch #{CREW_DEST_PREFIX}/var/lib/dpkg/status"
      system "mkdir -p #{CREW_DEST_PREFIX}/lib/perl5/site_perl/"
      system "mv #{CREW_DEST_PREFIX}/Dpkg.pm #{CREW_DEST_PREFIX}/lib/perl5/site_perl/"
      system "mv #{CREW_DEST_PREFIX}/Dpkg/ #{CREW_DEST_PREFIX}/lib/perl5/site_perl/"
    end
    Dir.chdir ("#{CREW_DEST_PREFIX}/bin") do
      system 'mv dpkg dpkg-run'
      system "echo '#!/bin/bash' > dpkg"
      system 'echo "PATH=\'${PATH}:/usr/local/sbin:/usr/sbin:/sbin\'" >> dpkg'
      system 'echo "fakeroot dpkg-run --force-not-root --force-depends --root=#{CREW_PREFIX} \'$@\'" >> dpkg'
      system 'chmod a+x dpkg'
    end
    Dir.chdir ("#{CREW_DEST_PREFIX}") do
      # This will make dpkg run without root
      system "sudo", "chown", "-R", "#{USER}:#{USER}", "./var/lib/dpkg"
    end
  end

  def self.postinstall
    if File.exists? "#{CREW_PREFIX}/var/lib/dpkg/status.old" then
      system "cat #{CREW_PREFIX}/var/lib/dpkg/status.old >> #{CREW_PREFIX}/var/lib/dpkg/status"
      system "rm #{CREW_PREFIX}/var/lib/dpkg/status.old"
    end
  end
end
