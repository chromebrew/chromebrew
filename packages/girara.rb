require 'buildsystems/meson'

class Girara < Meson
  description 'Girara is a library that implements a user interface that focuses on simplicity and minimalism'
  homepage 'https://pwmt.org/projects/girara/'
  version '2026.07.18'
  license 'ZLIB'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://pwmt.org/projects/girara/download/girara-#{version}.tar.xz"
  source_sha256 'd7255635776a45d42d1e555aa425ab96caf23755442474cf240cbac966d8502f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a3c69c823194f2504967cf347b59792a3030870bbfb66456e535a132735c2030',
     armv7l: 'a3c69c823194f2504967cf347b59792a3030870bbfb66456e535a132735c2030',
     x86_64: '54521d0ac0f194014a1dfac0210555bddc52ea0bc46abb729df12bef135b4541'
  })

  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gtk3' => :library
  depends_on 'json_c' => :library
  depends_on 'json_glib' => :library
end
