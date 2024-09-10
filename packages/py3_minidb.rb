require 'buildsystems/pip'

class Py3_minidb < Pip
  description 'Minidb is a simple SQLite3-based store for Python objects.'
  homepage 'https://thp.io/2010/minidb/'
  version '2.0.8-py3.12'
  license 'ISC'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f40d69646685bef91a26546ec506760bb1fbf581d75a621300c569b127d56c0f',
     armv7l: 'f40d69646685bef91a26546ec506760bb1fbf581d75a621300c569b127d56c0f',
       i686: '2e711fe06f4321010895979f72e30d203cace87140927f0a5f3e5fde107a0fe0',
     x86_64: '7992c0a58bd9df23802570c7333408835716de652ba5754bd998ee1411c88477'
  })

  depends_on 'python3' => :build

  no_source_build
end
