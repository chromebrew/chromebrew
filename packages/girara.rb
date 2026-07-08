require 'buildsystems/meson'

class Girara < Meson
  description 'Girara is a library that implements a user interface that focuses on simplicity and minimalism'
  homepage 'https://pwmt.org/projects/girara/'
  version '2026.07.07'
  license 'ZLIB'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://pwmt.org/projects/girara/download/girara-#{version}.tar.xz"
  source_sha256 '475f154148647d45e0f1324762fe5452094147085fddf2ccef4e9725c335b0c1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bb2e34590de1fc10640d9bde869c76ab94e7c89eba5a21e92695ad7d42fbfc93',
     armv7l: 'bb2e34590de1fc10640d9bde869c76ab94e7c89eba5a21e92695ad7d42fbfc93',
     x86_64: 'be86facbba3df9ac6fadcadcfb5bb2b01e425d93b2f8091dd6f428613e792dbe'
  })

  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gtk3' => :library
  depends_on 'json_c' => :library
  depends_on 'json_glib' => :library
end
