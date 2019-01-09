require 'package'

class Xhost < Package
	description 'Server access control program for X'
	homepage 'https://github.com/freedesktop/xorg-xhost'
	version '1.0.7'
	source_url 'https://github.com/freedesktop/xorg-xhost/archive/xhost-1.0.7.tar.gz'
	source_sha256 '1dd87b189cdd2921aec225eae630cc21113164b9a8654d1ed99613f3cda7be6a'

	def self.build
		system "./autogen.sh", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
		system "make"
	end

	def self.install
		system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
	end

	def self.check
		system "make", "check"
	end
end

