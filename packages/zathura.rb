require 'package'

class Zathura < Package
  description 'zathura is a highly customizable and functional PDF document viewer'
  homepage 'https://pwmt.org/projects/zathura/'
  version '0.4.5'
  source_url 'https://pwmt.org/projects/zathura/download/zathura-0.4.5.tar.xz'
  source_sha256 '0c3997aafbcdaaae60a4522f208adadfdd2758b432ce94ea16fbcee937cb762c'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'meson' => :build
  depends_on 'gettext' => :build
  depends_on 'girara'

  def self.build
    system "meson  --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

end
