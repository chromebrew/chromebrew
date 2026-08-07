require 'buildsystems/pip'

class Py3_pybind11 < Pip
  description 'Seamless operability between C++11 and Python'
  homepage 'https://github.com/pybind/pybind11'
  version "3.0.4-#{CREW_PY_VER}"
  license 'BSD-3 Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e8d4b3d785a8cd3ddb8e59607eb30b79289c1bb87f0ed19e6dd44afbbfb98f0f',
     armv7l: 'e8d4b3d785a8cd3ddb8e59607eb30b79289c1bb87f0ed19e6dd44afbbfb98f0f',
       i686: 'ccebd02eaa4bba1142b9994196c464652b2fc8af484a64976f92697b7d9d86ab',
     x86_64: '8e38f01d81fcc3151b55b30c39ae9390f78dcac2c7f4d9a28b232d5b48b28599'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
