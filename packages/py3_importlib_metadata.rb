require 'buildsystems/pip'

class Py3_importlib_metadata < Pip
  description 'Importlib metadata reads metadata from Python packages.'
  homepage 'https://github.com/python/importlib_metadata/'
  version "10.1.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1995538a6ccc243fe15c2b29ddf7bd5a3335e17c30258b80a0c877f43b39cc97',
     armv7l: '1995538a6ccc243fe15c2b29ddf7bd5a3335e17c30258b80a0c877f43b39cc97',
       i686: '62d7ae5e70ffaea58a196638559fe8645da0d67b8987ffbd8ac5d829b28860d0',
     x86_64: '021d9f5531828875da84c9a6631fe399e436434dfeb55c84d56716b3ec2ef8a3'
  })

  depends_on 'py3_zipp'
  depends_on 'python3' => :logical

  no_source_build
end
