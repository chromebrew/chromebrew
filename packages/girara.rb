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
    aarch64: 'ac915089fefb5eb17965c2603a508a802e6e08a701b2b3801539a6e0958410bc',
     armv7l: 'ac915089fefb5eb17965c2603a508a802e6e08a701b2b3801539a6e0958410bc',
     x86_64: '9648c9af8d3fb26b8f93ebc5c7df1274545625e1ee8aad37dcc0e0dd6827f8ea'
  })

  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gtk3' => :library
  depends_on 'json_c' => :library
  depends_on 'json_glib' => :library
end
