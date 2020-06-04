require 'package'

class Girara < Package
  description 'Girara is a library that implements a user interface that focuses on simplicity and minimalism'
  homepage 'https://pwmt.org/projects/girara/'
  version '0.3.4'
  source_url 'https://git.pwmt.org/pwmt/girara/-/archive/0.3.4/girara-0.3.4.tar.bz2'
  source_sha256 'e78257e4218a0f7f59cc1bea472c7c6794fa51cd9261d87affbe731c1e22c6a5'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'meson' => :build
  depends_on 'gettext' => :build
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
