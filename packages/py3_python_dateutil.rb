require 'buildsystems/pip'

class Py3_python_dateutil < Pip
  description 'Dateutil provides extensions to the standard Python datetime module.'
  homepage 'https://dateutil.readthedocs.io/'
  version "2.9.0.post0-#{CREW_PY_VER}"
  license 'BSD-3 and Apache-2.0 or BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5720f50bf626daa79e0b921ecbb369d9735dd86b2075cec95d95bf2028a79547',
     armv7l: '5720f50bf626daa79e0b921ecbb369d9735dd86b2075cec95d95bf2028a79547',
       i686: 'e3b4692d861e2af6a222e9126ebe33dc9dab2677bb6fb835af464b2cc9acc564',
     x86_64: '61a177b72a1b41e175a7c23c6dbecf6ac374ddf4a72120dae2ea0f536e8e0172'
  })

  depends_on 'python3' => :logical

  no_source_build
end
