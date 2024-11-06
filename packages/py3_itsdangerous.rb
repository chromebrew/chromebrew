require 'buildsystems/pip'

class Py3_itsdangerous < Pip
  description 'ItsDangerous provide various helpers to pass data to untrusted environments and back.'
  homepage 'https://palletsprojects.com/p/itsdangerous/'
  version "2.2.0-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '46c6bb4a28c70160611cb6405be56708bd6f9dc0de8acaa03745f2d8236dbb52',
     armv7l: '46c6bb4a28c70160611cb6405be56708bd6f9dc0de8acaa03745f2d8236dbb52',
       i686: '0b138130bb6b1bff3ff5cfafea4036d051529ef52ee4eede99faf3ab714bc0a5',
     x86_64: '7d12a9199b418b9cff1894ce3d48c343bddf714350452b0ad1b52f2ed2965da1'
  })

  depends_on 'python3' => :build

  no_source_build
end
