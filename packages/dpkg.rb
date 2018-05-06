require 'package'

class Dpkg < Package
  description 'dpkg, a medium-level package manager for Debian'
  homepage 'https://anonscm.debian.org/git/dpkg/'
  version '1.19.0.5'
  source_url 'https://salsa.debian.org/dpkg-team/dpkg/-/archive/master/dpkg-master.tar.gz'
  source_sha256 'a64b257d89d95f2e199fb39c6b37bf9de9e15e2d1e1898060fa9c9af3899330e'

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
  end
end
