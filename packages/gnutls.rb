require 'package'

class Gnutls < Package
	version '3.3.15'
	source_url 'ftp://ftp.gnutls.org/gcrypt/gnutls/v3.3/gnutls-3.3.15.tar.xz'
	source_sha1 'd7f66b0aeaf48ff8621cc1913230635ef672f0a4'

	depends_on 'buildessential'
	depends_on 'nettle'
	depends_on 'pkgconfig'

	def self.build
		system "./configure"
		system "make"
	end

	def self.install
		system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
	end
end
