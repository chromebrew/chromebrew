require 'buildsystems/pip'

class Dtrx < Pip
  description "An intelligent archive extraction tool for UNIX-like systems standing for 'Do The Right Extraction.'"
  homepage 'https://github.com/dtrx-py/dtrx/'
  version "8.5.3-#{CREW_PY_VER}"
  license 'GPL-3+'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '65e071be678871b34d248d7500b8710905b1365a508074d69c89fa213bc0e659',
     armv7l: '65e071be678871b34d248d7500b8710905b1365a508074d69c89fa213bc0e659',
       i686: 'ee15458799363a535e7b02af32e58c0afa17fecba53bf6137180e74ca1fcdf3b',
     x86_64: '970f4425b1440daec99d5f0e78a5a51f863acfb937048a611ef2ea5062074874'
  })

  depends_on 'py3_unsupported_python' => :build
  depends_on 'python3' => :build

  no_source_build
end
