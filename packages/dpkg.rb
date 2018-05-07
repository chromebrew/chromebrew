require 'package'

class Dpkg < Package
  description 'A medium-level package manager for Debian'
  homepage 'https://anonscm.debian.org/git/dpkg/'
  version '1.19.0.5'
  source_url 'https://salsa.debian.org/dpkg-team/dpkg/-/archive/1.19.0.5/dpkg-1.19.0.5.tar.gz'
  source_sha256 'd38308afcd5d7896bbd1f946875b90f9d8510a8a96b44e4f14e781285e5d9641'

    depends_on 'icu4c' => :build

    def self.build
	    system "ARCH = `uname -m`.strip"
            system "ARCH_LIB = if ARCH == 'x86_64' then 'lib64' else 'lib' end"          
            system "CREW_LIB_PREFIX = /usr/local + '/' + ARCH_LIB"
	    system "git clone https://salsa.debian.org/dpkg-team/dpkg.git"
	Dir.chdir ("dpkg")
	    system "git checkout 1.19.0.5"
	    system "autoreconf -i -f"
	    system "./configure --libdir=#{CREW_LIB_PREFIX} --prefix=/usr/local"
	    system "make"
	end

	def self.install
	    system "make install DESTDIR=/usr/local/${ARCH_LIB}"
	    system "ln -s /usr/ /usr/local/usr"
	    system "mkdir -p /usr/local/var/lib/dpkg"
	    system "touch /usr/local/var/lib/dpkg/status"
  end
end
