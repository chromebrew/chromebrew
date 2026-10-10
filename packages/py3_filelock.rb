require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "4.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c88aecfae88eaddeaee70139572cb66679dd8db5f9883fbeba2bd0775b5e1173',
     armv7l: 'c88aecfae88eaddeaee70139572cb66679dd8db5f9883fbeba2bd0775b5e1173',
       i686: '46b8f8db7a8b35775df9799761c2c8e83d0305aabf1aacc480272a57ca5c6b0d',
     x86_64: '6d84b090ba09305d5c3eae9b17463897d5a5fbb3087526730fd1873bef8cba96'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
