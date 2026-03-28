require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/benediktschmitt/py-filelock/'
  version "3.25.2-#{CREW_PY_VER}"
  license 'Unlicense'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e9c7be9ffc46349a6c66658aa5b4816f0499e8d311c70b8c3a54ad29d6877cfa',
     armv7l: 'e9c7be9ffc46349a6c66658aa5b4816f0499e8d311c70b8c3a54ad29d6877cfa',
       i686: '6b7db9205c443c12549dabb81c81b28f5cc5909c18a0c52aea6b3ccdfa14e3ab',
     x86_64: 'a4fff7d9328453f61323506072909a4cb3d82af5523bc544f88a4d5384bbcce6'
  })

  depends_on 'python3' => :logical

  no_source_build
end
