require 'buildsystems/pip'

class Py3_dnspython < Pip
  description 'DNSPython is a DNS toolkit.'
  homepage 'https://www.dnspython.org/'
  version "2.7.0-#{CREW_PY_VER}"
  license 'ISC'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7c281e4c16ef58a393f4875c866a58818b192bcf8231af6e3500608dfd996c73',
     armv7l: '7c281e4c16ef58a393f4875c866a58818b192bcf8231af6e3500608dfd996c73',
       i686: '53b3dea9854a55798d90c6eedb7dc00d0d69979b0c49be5b63340a441f108ab6',
     x86_64: 'f7839f4bb4a56a2e32ff64daed07ae147a2bfa91c3ef0516ce6c959fc6ed87da'
  })

  depends_on 'python3' => :build

  no_source_build
end
