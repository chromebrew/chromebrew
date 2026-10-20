require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "4.2.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c87d13cb5a777e7c26cc40def473373476ee180cfecc68614916b154de37367',
     armv7l: '0c87d13cb5a777e7c26cc40def473373476ee180cfecc68614916b154de37367',
       i686: 'd0ba9f4f07ad44b6f3a9e818526a9a52f34a11cca91c1a70b8189130eb5c8d6f',
     x86_64: '2ba4ab830132b7792c3b9b22b82c9fe64a8310e73d53cef6c0effb7918047f0e'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
