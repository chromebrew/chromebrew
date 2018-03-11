require 'package'

class Libcroco < Package
  description 'Generic Cascading Style Sheet (CSS) parsing and manipulation toolkit.'
  homepage 'https://git.gnome.org/browse/libcroco/'
  version '0.6.12'
  source_url 'http://ftp.gnome.org/pub/gnome/sources/libcroco/0.6/libcroco-0.6.12.tar.xz'
  source_sha256 'ddc4b5546c9fb4280a5017e2707fbd4839034ed1aba5b7d4372212f34f84f860'

  binary_url ({
  })
  binary_sha256 ({
  })
  
  depends_on 'libxml2'
  depends_on 'gtk_doc'

  def self.build
    system "sh autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "pip install six"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "pip uninstall --yes six"
  end
  
end
