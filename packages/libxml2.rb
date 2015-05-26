require 'package'

class Libxml2 < Package
	version '2.9.2'
	source_url 'ftp://xmlsoft.org/libxml2/libxml2-2.9.2.tar.gz'
	source_sha1 'f46a37ea6d869f702e03f393c376760f3cbee673'

	depends_on 'buildessential'

	def self.build
		system "./configure"
		system "make"
	end

	def self.install
		system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
	end
end
