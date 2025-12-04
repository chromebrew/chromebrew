require 'buildsystems/pip'

class Dtrx < Pip
  description "An intelligent archive extraction tool for UNIX-like systems standing for 'Do The Right Extraction.'"
  homepage 'https://github.com/dtrx-py/dtrx/'
  version "8.7.1-#{CREW_PY_VER}"
  license 'GPL-3+'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '65e071be678871b34d248d7500b8710905b1365a508074d69c89fa213bc0e659',
     armv7l: '65e071be678871b34d248d7500b8710905b1365a508074d69c89fa213bc0e659',
       i686: 'ee15458799363a535e7b02af32e58c0afa17fecba53bf6137180e74ca1fcdf3b',
     x86_64: 'e711b1c49ac97d505f8f00a624f11acca5547b90e09d4c73de7ad58c214ca579'
  })

  depends_on 'py3_unsupported_python' => :build
  depends_on 'python3' => :build

  no_source_build
end
