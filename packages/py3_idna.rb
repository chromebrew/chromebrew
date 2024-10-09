require 'buildsystems/pip'

class Py3_idna < Pip
  description 'IDNA provides internationalized domain names for Python.'
  homepage 'https://github.com/kjd/idna/'
  version "3.10-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '48bd091cf8e829ed1082bcc0fd96aecf71154dcf239483f2b642b20e670fdc05',
     armv7l: '48bd091cf8e829ed1082bcc0fd96aecf71154dcf239483f2b642b20e670fdc05',
       i686: '6c179ed14684b9dbba85e50fb0d4dd03f0c25e86a6fc0080284c75b4bb4791ab',
     x86_64: 'bdc9ecc643b56ac0720a70f3f955c23f190612f646a0fb1fcaebdf17d6a7263b'
  })

  depends_on 'python3' => :build

  no_source_build
end
