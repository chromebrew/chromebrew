require 'buildsystems/pip'

class Py3_oci < Pip
  description 'Oracle Cloud Infrastructure Python SDK'
  homepage 'https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/'
  version '2.133.0-py3.12'
  license 'UPL-1.0 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '392589e29713e916dc8420afd59a0f9662bf577ac3f6476366a24e76a97b7d3f',
     armv7l: '392589e29713e916dc8420afd59a0f9662bf577ac3f6476366a24e76a97b7d3f',
       i686: '9654d5c0281480c6f334789bd4268c1171e35865691f8bc0f195a4617852f6db',
     x86_64: '8df9355d27ebdbbe98141482f0e6ec054ee41b5d22b059e6a919e12ce98444c9'
  })

  depends_on 'py3_python_dateutil'
  depends_on 'py3_configparser'
  depends_on 'py3_pyopenssl'
  depends_on 'py3_certifi'
  depends_on 'py3_pytz'
  depends_on 'py3_cryptography'
  depends_on 'python3' => :build
  depends_on 'rust' => :build

  no_source_build
end
