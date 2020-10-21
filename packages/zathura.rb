require 'package'

class Zathura < Package
  description 'zathura is a highly customizable and functional PDF document viewer'
  homepage 'https://pwmt.org/projects/zathura/'
  version '0.4.7'
  compatibility 'aarch64,armv7l,x86_64'
  case ARCH
  when 'aarch64', 'armv7l', 'x86_64'
    source_url 'https://pwmt.org/projects/zathura/download/zathura-0.4.7.tar.xz'
    source_sha256 'e012dbfe2b981b826553a9af8420d42a9c5d3387fbe14a5399ce94a2d374a1e7'
    depends_on 'appstream_glib'
    depends_on 'bash_completion'
    depends_on 'desktop_file_utilities'
    depends_on 'fish'
    depends_on 'girara'
    depends_on 'libseccomp'
    depends_on 'zathura_poppler_pdf'
  end

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/zathura-0.4.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/zathura-0.4.7-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/zathura-0.4.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '401655bbb1a8f83cbcd158e67370abc105a292027f8b35ccbe6af04755b33d61',
     armv7l: '401655bbb1a8f83cbcd158e67370abc105a292027f8b35ccbe6af04755b33d61',
     x86_64: '7b56a87ff85d05ebcd9c8ea7cad130f861d9f3f6deaad0e8934ccc24ab4f87f1',
  })

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} -Dmanpages=disabled -Dsynctex=disabled builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
