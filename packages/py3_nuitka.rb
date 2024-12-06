require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.5.6-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f95a0358345de533bcedb79390c2339b7fe8235e6f9d2b5cfecc445f60c468b0',
     armv7l: 'f95a0358345de533bcedb79390c2339b7fe8235e6f9d2b5cfecc445f60c468b0',
       i686: 'b82b10493d2ea0c0d89a388ceaecc0ec48b38afcb33e3ba0a55a44e5b8fe9a48',
     x86_64: 'f36cbf1fdf7d1f5a58129338e83ef96288473267a7229fba647d89cc0b39acde'
  })

  depends_on 'python3' => :build

  no_source_build
end
