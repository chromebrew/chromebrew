require 'buildsystems/pip'

class Py3_python_discovery < Pip
  description 'Python interpreter discovery'
  homepage 'https://github.com/tox-dev/python-discovery'
  version "1.6.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4b238971a698a1a8fcdb9039d5bdf68646c880f98d382e38420cf12d1dec8812',
     armv7l: '4b238971a698a1a8fcdb9039d5bdf68646c880f98d382e38420cf12d1dec8812',
       i686: '64dee18cac3f7e513e39ecc9b0bda4d51d1a432713394b515b102b96b9d03a60',
     x86_64: 'e3a58d9198cbfae02c1ae4d6c04cdf3ca277e6ded4f66431e6adf217d6de3092'
  })

  depends_on 'python3' => :logical

  no_source_build
end
