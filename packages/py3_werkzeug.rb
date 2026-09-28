require 'buildsystems/pip'

class Py3_werkzeug < Pip
  description 'Werkzeug is a comprehensive WSGI web application library.'
  homepage 'https://palletsprojects.com/p/werkzeug/'
  version "3.1.9-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'db1ce12b41d7a14804e1e4d9197a4c286562ee3d17dc485c82c301b65a1b6398',
     armv7l: 'db1ce12b41d7a14804e1e4d9197a4c286562ee3d17dc485c82c301b65a1b6398',
       i686: 'cbc7f32d9fd107ba4e85680b8e76662cbf2be0207f4e7e4b85bfc139d21afa97',
     x86_64: '9e6c11573afafbe7882bd00e2030288e4637afc22934e614e6ecc4e4fe9299a2'
  })

  depends_on 'python3' => :logical

  no_source_build
end
