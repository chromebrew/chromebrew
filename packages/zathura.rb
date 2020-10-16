require 'package'

class Zathura < Package
  description 'zathura is a highly customizable and functional PDF document viewer'
  homepage 'https://pwmt.org/projects/zathura/'
  version '0.4.7'
  compatibility 'all'
  source_url 'https://pwmt.org/projects/zathura/download/zathura-0.4.7.tar.xz'
  source_sha256 'e012dbfe2b981b826553a9af8420d42a9c5d3387fbe14a5399ce94a2d374a1e7'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'girara'
  depends_on 'zathura_poppler_pdf'

  def self.build
    system "meson  --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
