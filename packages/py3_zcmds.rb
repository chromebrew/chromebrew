# Currently breaks the system by replacing coreutils binaries with symlinks to python...
require 'buildsystems/pip'

class Py3_zcmds < Pip
  description 'Cross platform(ish) productivity commands written in python'
  homepage 'https://github.com/zackees/zcmds'
  version "1.4.100-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'aarch64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  no_source_build
end
