require 'package'

class Dpkg < Package
  description 'A medium-level package manager for Debian'
  homepage 'https://anonscm.debian.org/git/dpkg/'
  version '1.19.0.5-test'
  source_url 'https://salsa.debian.org/dpkg-team/dpkg/-/archive/1.19.0.5/dpkg-1.19.0.5.tar.gz'
  source_sha256 'd38308afcd5d7896bbd1f946875b90f9d8510a8a96b44e4f14e781285e5d9641'

  depends_on 'icu4c' => :build

  def self.build
    system "git clone https://salsa.debian.org/dpkg-team/dpkg.git"
    Dir.chdir ("dpkg") do
      system "git checkout 1.19.0.5"
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
      system "ln -s #{CREW_PREFIX} #{CREW_DEST_PREFIX}/usr/local"
      system "mkdir -p #{CREW_DEST_PREFIX}/var/lib/dpkg/"
      system "touch #{CREW_DEST_PREFIX}/var/lib/dpkg/status"
    end
    Dir.chdir ("#{CREW_DEST_PREFIX}/bin") do
      system 'mv dpkg dpkg-run'
      system "echo '#!/bin/bash' > dpkg"
      system "echo 'dpkg-run --force-depends --root=#{CREW_PREFIX} \"$@\"' >> dpkg"
      system 'chmod a+x dpkg'
    end
  end
      def self.postinstall
    if File.exists? "#{CREW_PREFIX}/var/lib/dpkg/status.old" then
      system "cat #{CREW_PREFIX}/var/lib/dpkg/status.old >> #{CREW_PREFIX}/var/lib/dpkg/status"
      system "rm #{CREW_PREFIX}/var/lib/dpkg/status.old"
    end
  end
end
