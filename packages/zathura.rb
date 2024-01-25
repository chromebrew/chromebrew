require 'buildsystems/meson'

class Zathura < Meson
  description 'zathura is a highly customizable and functional PDF document viewer'
  homepage 'https://pwmt.org/projects/zathura/'
  version '0.5.2'
  license 'ZLIB'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://pwmt.org/projects/zathura/download/zathura-0.5.2.tar.xz'
  source_sha256 'c64ba7cb9facf2b1499b9dc929b6736c72c69f8062eed4f2940556c852256194'
  binary_compression 'tar.zst'

  depends_on 'appstream_glib'
  depends_on 'desktop_file_utilities'
  depends_on 'girara'
  depends_on 'librsvg'
  depends_on 'libseccomp'
  depends_on 'zathura_poppler_pdf'

  binary_sha256({
    aarch64: '3cfbee5522f48b4f99d62d0c4f559320881012812b0f879e0592edf9b3fb608a',
     armv7l: '3cfbee5522f48b4f99d62d0c4f559320881012812b0f879e0592edf9b3fb608a',
     x86_64: 'a402bed68aff3ac037973935760317a4db6716049abe75bd456067798e190a46'
  })

  meson_options '-Dmanpages=disabled -Dsynctex=disabled'
end
