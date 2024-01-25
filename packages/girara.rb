require 'buildsystems/meson'

class Girara < Meson
  description 'Girara is a library that implements a user interface that focuses on simplicity and minimalism'
  homepage 'https://pwmt.org/projects/girara/'
  version '0.4.0'
  license 'ZLIB'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://pwmt.org/projects/girara/download/girara-0.4.0.tar.xz'
  source_sha256 'ceafd0a6aed50ad832ba766ec629f1ea366681c15f8fa728a8f55418c39dc901'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bdae13227ad4229a14cfdc9f5208931b546115fb9fe953d2d8ceba049b6536e8',
     armv7l: 'bdae13227ad4229a14cfdc9f5208931b546115fb9fe953d2d8ceba049b6536e8',
     x86_64: '46ba52550665ecc3e54cfc919f404b7bb0943a16fda7f0d74b4da6073dbdacf0'
  })

  depends_on 'gtk3'
  depends_on 'glib'
  depends_on 'jsonc'
  depends_on 'json_glib'
end
