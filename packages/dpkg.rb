require 'package'

class Dpkg < Package
  description 'A medium-level package manager for Debian'
  homepage 'https://anonscm.debian.org/git/dpkg/'
  version '1.19.0.5-1'
  source_url 'https://salsa.debian.org/dpkg-team/dpkg/-/archive/1.19.0.5/dpkg-1.19.0.5.tar.gz'
  source_sha256 'd38308afcd5d7896bbd1f946875b90f9d8510a8a96b44e4f14e781285e5d9641'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dpkg-1.19.0.5-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dpkg-1.19.0.5-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dpkg-1.19.0.5-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dpkg-1.19.0.5-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ec2d481788b7ccc43edbc56a62b999fffafa720e30ff90ddc84e5678a1e947d5',
     armv7l: 'ec2d481788b7ccc43edbc56a62b999fffafa720e30ff90ddc84e5678a1e947d5',
       i686: '1eb3da48f913f05718c2e35beea9aa7d147a0fbd09888226afd06a48b0b665df',
     x86_64: '1ba5f80a00c05273cd2a0dcb7bfc789e5f7cc741d5dca65487a33312c35114a2',
  })

  depends_on 'bz2'
  depends_on 'xzutils'

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
      system "mkdir -p #{CREW_DEST_PREFIX}/lib/perl5/site_perl/"
      system "ln -s #{CREW_PREFIX}/Dpkg.pm #{CREW_DEST_PREFIX}/lib/perl5/site_perl/"
      system "ln -s #{CREW_PREFIX}/Dpkg/ #{CREW_DEST_PREFIX}/lib/perl5/site_perl/"
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
