require 'package'

class Scheme48 < Package
  description 'Scheme byte-code interpreter'
  homepage 'http://s48.org/'
  version '1.9.2'
  source_url 'http://s48.org/1.9.2/scheme48-1.9.2.tgz'
  source_sha256 '9c4921a90e95daee067cd2e9cc0ffe09e118f4da01c0c0198e577c4f47759df4'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
