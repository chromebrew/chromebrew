require 'package'

class Nettle < Package
	version '2.7.1'
	source_url 'https://ftp.gnu.org/gnu/nettle/nettle-2.7.1.tar.gz'
	source_sha1 'e7477df5f66e650c4c4738ec8e01c2efdb5d1211'

	depends_on 'buildessential'
	depends_on 'm4'

	def self.build
		system "./configure"
		system "make"
	end

	def self.install
		system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
	end
end
