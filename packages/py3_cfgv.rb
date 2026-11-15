require 'buildsystems/pip'

class Py3_cfgv < Pip
  description 'Validate configuration and produce human readable error messages.'
  homepage 'https://github.com/asottile/cfgv'
  version "3.5.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2f7ff9921f6ec5dd68e400923d813d3fed3cbe69426a43fe54766680ff09994c',
     armv7l: '2f7ff9921f6ec5dd68e400923d813d3fed3cbe69426a43fe54766680ff09994c',
       i686: 'f4da685d1b4ff017939fbfb06ca799203ba550dd7210d953bae1745dec927881',
     x86_64: '9cb2d7b70f9fc070b52bb357c16e28280109840cec289d9cec06d78dd63527df'
  })

  depends_on 'python3' => :logical

  no_source_build
end
