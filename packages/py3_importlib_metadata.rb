require 'buildsystems/pip'

class Py3_importlib_metadata < Pip
  description 'Importlib metadata reads metadata from Python packages.'
  homepage 'https://github.com/python/importlib_metadata/'
  version "9.0.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2f92fd106a21debec53fc374b562f14ee795fd6e00fba2af4238d462d2d3c6ff',
     armv7l: '2f92fd106a21debec53fc374b562f14ee795fd6e00fba2af4238d462d2d3c6ff',
       i686: 'bb42ebe71337c0d6e59d103991bd05a4a50c79fa37a56afe8498d28ea89277b6',
     x86_64: 'ece35899d94b0d04936b73815d26860dbdb2c7aca977bfa2577321d356a5c459'
  })

  depends_on 'py3_zipp'
  depends_on 'python3' => :logical

  no_source_build
end
