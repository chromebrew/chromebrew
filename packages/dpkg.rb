require 'package'

class Dpkg < Package
  description 'A medium-level package manager for Debian'
  homepage 'https://anonscm.debian.org/git/dpkg/'
  version '1.19.0.5'
  source_url 'https://salsa.debian.org/dpkg-team/dpkg/-/archive/1.19.0.5/dpkg-1.19.0.5.tar.gz'
  source_sha256 'd38308afcd5d7896bbd1f946875b90f9d8510a8a96b44e4f14e781285e5d9641'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dpkg-1.19.0.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dpkg-1.19.0.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dpkg-1.19.0.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dpkg-1.19.0.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd947f4af5584d878462fdb0b7fce220ae3b1f15a6140ec2ed3cf447f8ea80fbb',
     armv7l: 'd947f4af5584d878462fdb0b7fce220ae3b1f15a6140ec2ed3cf447f8ea80fbb',
       i686: '19f40a5186dccbe3a135defe6440b2b5c4f0c05d5b4878046e8fb23b330978d5',
     x86_64: '2075f9d91e997890c2906e0b1c53e705bfd97b99b14de4fd5e1cb9ca3a67b038',
  })

  depends_on 'bz2'
  depends_on 'xzutils'
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
