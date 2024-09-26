require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.6.8-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd046b72265e6220f704249f4559d2ce776ca0143d39acea41143f3904c81f6d5',
     armv7l: 'd046b72265e6220f704249f4559d2ce776ca0143d39acea41143f3904c81f6d5',
       i686: '2375e9b6589c5a97c292e81790f6a194e04500961f5c3e15aaaf845a79511f79',
     x86_64: '0c2d141ada33069799ed8f40a160ce8c858bfc7c430bf64485693ab4919bf293'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'rust' => :build

  no_source_build
end
