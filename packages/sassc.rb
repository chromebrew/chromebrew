require 'package'

class Sassc < Package
  description 'C implementation of Sass CSS preprocessor.'
  version '3.6.1'
  compatibility 'all'
  source_url 'https://github.com/sass/sassc/archive/3.6.1.tar.gz'
  source_sha256 '8cee391c49a102b4464f86fc40c4ceac3a2ada52a89c4c933d8348e3e4542a60'

  depends_on 'libsass'

  def self.build
    system "autoreconf -i"
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end
  
  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
