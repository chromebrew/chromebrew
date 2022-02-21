require 'package'

class Libbytesize < Package
  description 'A tiny library providing a C "class" for working with arbitrary big sizes in bytes'
  homepage 'https://github.com/storaged-project/libbytesize'
  version '2.6'    
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/storaged-project/libbytesize/releases/download/2.6/libbytesize-2.6.tar.gz'
  source_sha256 'efaa2b35b2bb3b52bf7b4ff5d0ed2c5c61360a5196053808d615dd0aa2cf0741'

  depends_on 'gawk' => :build
  
  def self.build
    system "./configure #{CREW_OPTIONS} --with-gtk-doc=no"
    system "make"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
