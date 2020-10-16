require 'package'

class Girara < Package
  description 'Girara is a library that implements a user interface that focuses on simplicity and minimalism'
  homepage 'https://pwmt.org/projects/girara/'
  version '0.3.5'
  compatibility 'all'
  source_url 'https://pwmt.org/projects/girara/download/girara-0.3.5.tar.xz'
  source_sha256 'e33ba2a21dd57606439d37c829d48466a14e3e50a698e6bd678b511f5c59f4b5'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gtk3'
  depends_on 'glib'

  def self.build
    system "meson  --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

end
