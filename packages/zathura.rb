require 'buildsystems/meson'

class Zathura < Meson
  description 'zathura is a highly customizable and functional PDF document viewer'
  homepage 'https://pwmt.org/projects/zathura/'
  version '2026.10.23'
  license 'ZLIB'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://pwmt.org/projects/zathura/download/zathura-#{version}.tar.xz"
  source_sha256 '29a0931527f63c832f50eeef169d885a5db52a3a9e13b12a3a7beca9aaf63d2d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd1918bbf60fdde604155880ddff77e3682c6addc1c97e10f2bf994bae7724729',
     armv7l: 'd1918bbf60fdde604155880ddff77e3682c6addc1c97e10f2bf994bae7724729',
     x86_64: '652f3e23c8a7d6b3cca1749e8f57f4b7bc8bac936e27ba49533240ada10dbf0a'
  })

  depends_on 'appstream' => :executable
  depends_on 'appstream_glib' => :executable
  depends_on 'cairo' => :executable
  depends_on 'desktop_file_utilities'
  depends_on 'filecmd' => :executable
  depends_on 'girara' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'graphene' => :executable
  depends_on 'gtk4' => :executable
  depends_on 'json_glib' => :executable
  depends_on 'librsvg' => :executable
  depends_on 'libseccomp' => :executable
  depends_on 'pango' => :executable
  depends_on 'weston' => :executable
  depends_on 'xvfb' => :executable
  depends_on 'xxhash' => :executable
  depends_on 'zathura_poppler_pdf' => :executable

  meson_options '-Dmanpages=disabled -Dsynctex=disabled'
end
