require 'package'

class Libarchive < Package
  description 'Multi-format archive and compression library.'
  homepage 'http://www.libarchive.org/'
  version '3.2.2-0'
  source_url 'http://www.libarchive.org/downloads/libarchive-3.2.2.tar.gz'
  source_sha256 '691c194ee132d1f0f7a42541f091db811bc2e56f7107e9121be2bc8c04f1060f'



  depends_on 'acl'
  depends_on 'attr'
  depends_on 'lz4'
  depends_on 'xzutils' => :build

  def self.build
    system "./configure \
          --prefix=#{CREW_PREFIX} \
          --libdir=#{CREW_LIB_PREFIX} \    
          --disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
