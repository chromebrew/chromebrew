require 'buildsystems/pip'

class Py3_importlib_metadata < Pip
  description 'Importlib metadata reads metadata from Python packages.'
  homepage 'https://github.com/python/importlib_metadata/'
  version "10.2.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '58d9a4bf079e18131cefb341f81e95bbd18db6deefbc7ae58f97288ae0d225f1',
     armv7l: '58d9a4bf079e18131cefb341f81e95bbd18db6deefbc7ae58f97288ae0d225f1',
       i686: '1d810d7fa51c4dead432e626faf0e2ede1cab5f981e543db1e74cd198a81faa1',
     x86_64: 'e0c45e553fb36513a90e4ed332704acbd02431c776e7388b9453c08da3b7804c'
  })

  depends_on 'py3_zipp'
  depends_on 'python3' => :logical

  no_source_build
end
