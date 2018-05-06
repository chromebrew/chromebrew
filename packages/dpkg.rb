require 'package'

class Dpkg < Package
  description 'A medium-level package manager for Debian'
  homepage 'https://anonscm.debian.org/git/dpkg/'
  version '1.19.0.5'
  source_url 'https://salsa.debian.org/dpkg-team/dpkg/-/archive/1.19.0.5/dpkg-1.19.0.5.tar.gz'
  source_sha256 'd38308afcd5d7896bbd1f946875b90f9d8510a8a96b44e4f14e781285e5d9641'

    depends_on 'icu4c' => :build

    def self.build
	    system "rm -rf {*,.*}"
	    system "git clone https://salsa.debian.org/dpkg-team/dpkg.git"
	Dir.chdir ("dpkg")
	    system "autoreconf -i -f"
	    system "./configure --libdir=#{CREW_LIB_PREFIX} --prefix=#{CREW_PREFIX}"
	    system "make"
	end

	def self.install 
	    system "make install DESTDIR=#{CREW_DEST_DIR}"
	    system "echo \"# Dpkg Alias (Do NOT Touch)\" >> ~/.bashrc"
	    system "echo \"alias dpkg=\"dpkg --root=/usr/local\"\" >> ~/.bashrc"
  end
end
