require 'buildsystems/pip'

class Py3_pyte < Pip
  description 'PyTE is a Simple VTXXX-compatible terminal emulator.'
  homepage 'https://github.com/selectel/pyte/'
  version "0.8.2-#{CREW_PY_VER}"
  license 'LGPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '82dc8bdeaccd7571b16a47cad7b1454d8f578b37c454c55f585b21fb79d52922',
     armv7l: '82dc8bdeaccd7571b16a47cad7b1454d8f578b37c454c55f585b21fb79d52922',
       i686: 'bad6dfef18935568a9458f74a348aa10a46b0b4b8d3ec4a9ebf3b91e6e8f6bc7',
     x86_64: 'f01cbe01bf2d038b2d113b6bb5a7c5f539ab5425d5b720bf79d582e3d1e32637'
  })

  depends_on 'py3_wcwidth'
  depends_on 'python3' => :logical

  no_source_build
end
