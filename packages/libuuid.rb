require 'package'

class Libuuid < Package
  description 'Portable uuid C library'
  homepage 'https://www.kernel.org'
  version '2.31'
  source_url 'https://www.kernel.org/pub/linux/utils/util-linux/v2.31/util-linux-2.31.1.tar.gz'
  source_sha256 'd636cb23a2a4aaeeec4b1b52c702366a83978f5a3aaf3029431e7a76a7095323'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-all-programs'
           '--enable-libuuid'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
