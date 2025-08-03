require 'buildsystems/pip'

class Py3_certifi < Pip
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/'
  version "2025.8.3-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a9645b513b9d6e1256fe8588ae1207ed979fb8247748c459e4db14e02a962561',
     armv7l: 'a9645b513b9d6e1256fe8588ae1207ed979fb8247748c459e4db14e02a962561',
       i686: 'f22591cf50000fde3bec38a5023d32a70ec2bd35c537d22d1b17ed80a4eeebc9',
     x86_64: '1f60e5e0d13fb1002ba69dd2fd87926be8c7e6cf2ddd60c870a15e9f2cdac446'
  })

  depends_on 'python3' # L

  no_source_build
end
