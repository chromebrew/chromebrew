require 'buildsystems/pip'

class Py3_werkzeug < Pip
  description 'Werkzeug is a comprehensive WSGI web application library.'
  homepage 'https://palletsprojects.com/p/werkzeug/'
  version "3.1.8-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '986e2c645a4adb8d0fe34bac31ddf3f2c901faa905c25ef32d184a6771b00043',
     armv7l: '986e2c645a4adb8d0fe34bac31ddf3f2c901faa905c25ef32d184a6771b00043',
       i686: '9465f5709507ca6a0fddf2b04ff006fe03f13abeab02f49c3a221dbdc4eed45a',
     x86_64: '9671f03c34f1ccf8eb634290e51d06a0d06ab7406da4b181557771bd0c1767b8'
  })

  depends_on 'python3' => :logical

  no_source_build
end
