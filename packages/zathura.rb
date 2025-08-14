require 'buildsystems/meson'

class Zathura < Meson
  description 'zathura is a highly customizable and functional PDF document viewer'
  homepage 'https://pwmt.org/projects/zathura/'
  version '0.5.12'
  license 'ZLIB'
  compatibility 'aarch64 armv7l x86_64'
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
    aarch64: 'bd1abb8bec1a93ed1d10b4757132a90e8222723e9bcac4cb76cc5437c6273f9c',
     armv7l: 'bd1abb8bec1a93ed1d10b4757132a90e8222723e9bcac4cb76cc5437c6273f9c',
     x86_64: '1daf155ca8ef931374a53d9e7e3fd733dc687e32a6b6e2f3d1aec3427f44d00a'
  })

  meson_options '-Dmanpages=disabled -Dsynctex=disabled'
end
