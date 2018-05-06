require 'package'

class Dpkg < Package
  description 'A medium-level package manager for Debian'
  homepage 'https://anonscm.debian.org/git/dpkg/'
  version '1.19.0.5'
  source_url 'https://salsa.debian.org/dpkg-team/dpkg/-/archive/1.19.0.5/dpkg-1.19.0.5.tar.gz'
  source_sha256 'd38308afcd5d7896bbd1f946875b90f9d8510a8a96b44e4f14e781285e5d9641'

    depends_on 'perl' => :build
    depends_on 'pkgconfig' => :build
    depends_on 'automake' => :build
    depends_on 'make' => :build
    depends_on 'gcc' => :build
    depends_on 'linuxheaders' => :build
    depends_on 'flex' => :build
    depends_on 'bison' => :build
    depends_on 'icu4c' => :build
    depends_on 'gettext' => :build
    depends_on 'autoconf' => :build
    depends_on 'libtool' => :build

    def self.build
	    system "sudo mount -o remount,rw -io exec ~/"
	    system "echo 'Thank you for entering your sudo password. It will be used to run the configure script.'"
	    system "rm -rf {*,.*}"
	    system "git clone https://salsa.debian.org/dpkg-team/dpkg.git"
	Dir.chdir ("dpkg")
	    system "autoreconf -i -f"
	    system "./configure --libdir=#{CREW_LIB_PREFIX} --prefix=#{CREW_PREFIX}"
	    system "make"
	end

	def self.install 
	    system "make install DESTDIR=#{CREW_DEST_DIR}"
	    system "alias dpkg='dpkg --root=/usr/local'"
  end
end
