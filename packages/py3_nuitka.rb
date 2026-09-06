require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "4.2.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6cef896c7ac9cbe2cc5a525554e37b8ee121a8ad2265f5c5015c67e69e670371',
     armv7l: '6cef896c7ac9cbe2cc5a525554e37b8ee121a8ad2265f5c5015c67e69e670371',
       i686: '026a2b7bd32bda2969fe3f2964bcfa91676f0d0f462ff31d78568f63fcf19410',
     x86_64: '8da11ab87dbd15e3a7ab45a3c95113e6d084c7531c1feaf986c8755aed55dbc3'
  })

  depends_on 'python3' => :logical

  no_source_build
end
