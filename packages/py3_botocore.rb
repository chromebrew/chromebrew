require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.33-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '166060ea655a028c89f409c7b1a00c27e9ee0509ed9ef13bce347665fdf28b7c',
     armv7l: '166060ea655a028c89f409c7b1a00c27e9ee0509ed9ef13bce347665fdf28b7c',
       i686: '55a91dff19470c45d4fa32567c0b7b5d3b3f78c97fb0470eb24e1962a5867a4b',
     x86_64: '4fd044a02bdc01fe67d106b3f32728078c9060a059a8be3615efd5c82c108e9c'
  })

  depends_on 'python3' => :logical

  no_source_build
end
