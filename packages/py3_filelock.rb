require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "3.31.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0863dad8ed9861ff0bc33a656a4e6bf75467580494f12147c6b32450085c4a78',
     armv7l: '0863dad8ed9861ff0bc33a656a4e6bf75467580494f12147c6b32450085c4a78',
       i686: '4652327cec6e1420c53b010c268272743b49c144c6b063eb3ba2c48173959597',
     x86_64: 'a40a53274bff126f59ae72eed5098649f4a0459b205cc3778ee86444db7ff15b'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
