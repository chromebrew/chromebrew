require 'buildsystems/pip'

class Py3_importlib_metadata < Pip
  description 'Importlib metadata reads metadata from Python packages.'
  homepage 'https://github.com/python/importlib_metadata/'
  version "8.6.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c420fc047cac1225a7660e22ab19f3cc939f48d9a32b4a7fc9e1473847acb9de',
     armv7l: 'c420fc047cac1225a7660e22ab19f3cc939f48d9a32b4a7fc9e1473847acb9de',
       i686: '72114da5222f860c5b0a936dee679c223f47e0d5f65a5af1bd0d4eff294adc77',
     x86_64: '4d29322a9f089a9e59f21adbd5c46c9eea73a533493910a5b723b6e8bb2b8eba'
  })

  depends_on 'py3_zipp'
  depends_on 'python3' => :build

  no_source_build
end
