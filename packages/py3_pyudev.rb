require 'buildsystems/pip'

class Py3_pyudev < Pip
  description 'Pyudev provides Python bindings for udev.'
  homepage 'https://pyudev.readthedocs.io/'
  version "0.24.3-#{CREW_PY_VER}"
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dc5904f922eed95d3e34d19a8d75fbc6b25eaac2a5896f23deb366b7060ea7b6',
     armv7l: 'dc5904f922eed95d3e34d19a8d75fbc6b25eaac2a5896f23deb366b7060ea7b6',
       i686: '26eff0e7c5e2e780946ca442a6cfd8d5a7e50f35e7aa0cae5fb5c10b341fe406',
     x86_64: '3580d0edd85a33d0012da3d45779f1b6ee1287c54a9e03c6c8219cce16146edb'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
