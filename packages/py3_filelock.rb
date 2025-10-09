require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/benediktschmitt/py-filelock/'
  version "3.20.0-#{CREW_PY_VER}"
  license 'Unlicense'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '995b5c75d0dd123a021b2c75824912848cc6296768be72e2dad3a7b821cf68b3',
     armv7l: '995b5c75d0dd123a021b2c75824912848cc6296768be72e2dad3a7b821cf68b3',
       i686: '9513fa2d55e8b36dcee309a26cbba3d3b849d715f5dff6564a5f1c16122ad74a',
     x86_64: 'e14487e0ac8d60c3e7c2bbe64480aeeb4f21b03eeab1f70eab6587739a6ce466'
  })

  depends_on 'python3' => :build

  no_source_build
end
