require 'buildsystems/pip'

class Py3_agate_dbf < Pip
  description 'Agate-dbf adds read support for DBF files to agate.'
  homepage 'https://agate-dbf.readthedocs.org/'
  version "0.2.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b724b64ebbc5131bd19d920f1098aad64268ffa9a5f2e0d5263e1df8c8609fd8',
     armv7l: 'b724b64ebbc5131bd19d920f1098aad64268ffa9a5f2e0d5263e1df8c8609fd8',
       i686: '265b109b1d43294455576944e12022752abf254c3d59527bffc775ce1e6785e8',
     x86_64: '4305e7982c6f22b2a4b0b0e3b8853b47d7da73642db915c4915498beb8317785'
  })

  depends_on 'py3_dbfread'
  depends_on 'py3_agate'
  depends_on 'python3' => :build

  no_source_build
end
