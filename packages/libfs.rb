require 'package'

class Libfs < Package
  description 'X.org library interface to the X Font Server.'
  homepage 'http://www.x.org'
  version '1.0.7'
  source_url 'https://www.x.org/archive/individual/lib/libFS-1.0.7.tar.gz'
  source_sha256 '91bf1c5ce4115b7dbf4e314fdbee54052708e8f7b6a2ec6e82c309bcbe40ef3d'

  depends_on 'xproto'
  depends_on 'fontsproto'
  depends_on 'libxtrans'
  depends_on 'util_macros'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end