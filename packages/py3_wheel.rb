require 'buildsystems/pip'

class Py3_wheel < Pip
  description 'Wheel is the binary package format for python.'
  homepage 'https://wheel.readthedocs.io/'
  version "0.46.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '26cc86d4d9e88e580995b488a33b70b9f8bdbe49923abed3ae943ceafdabfdd3',
     armv7l: '26cc86d4d9e88e580995b488a33b70b9f8bdbe49923abed3ae943ceafdabfdd3',
       i686: 'eb461f63889d77ad92cdb33085e7c762e8e40958c20ade7c4c3a068269cdd967',
     x86_64: 'ad2baf22378fc4a7e5f0e6272bca009600ecfc7b9fb8a4497fa76a567b9a0f60'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'

  no_source_build
end
