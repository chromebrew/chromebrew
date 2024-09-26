require 'buildsystems/pip'

class Py3_fasteners < Pip
  description 'Fasteners provides useful locks for python programs.'
  homepage 'https://github.com/harlowja/fasteners/'
  version "0.19-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9785767a63c35b4860a8cf2f305e37ef50584eb05eddb47a6789f9066bc83991',
     armv7l: '9785767a63c35b4860a8cf2f305e37ef50584eb05eddb47a6789f9066bc83991',
       i686: '3d450094d2ececac57e6c7ca0e417f3c3cfc5b8a02e40f12af03cc1e1d93a83d',
     x86_64: '41308db778c485c739a61bc6ebc7b36e7b9055904154defb907df80f0d951630'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
