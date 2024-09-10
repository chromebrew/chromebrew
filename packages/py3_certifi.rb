require 'buildsystems/pip'

class Py3_certifi < Pip
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/'
  version '2024.8.30-py3.12'
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cb0ba449977b6909f586476203a4419db540654607e075642ecc9d3d8f4ea13f',
     armv7l: 'cb0ba449977b6909f586476203a4419db540654607e075642ecc9d3d8f4ea13f',
       i686: '5d70d2de6cb2a7bacc2d74afac950f2a65e65787318a38079896f1175a4a20de',
     x86_64: '71ab5938d72a6ab17e14483c5fc0d4e8cfe7eba05aefc9f53eb52eb0093c8071'
  })

  depends_on 'python3' # L

  no_source_build
end
