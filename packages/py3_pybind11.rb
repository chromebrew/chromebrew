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
    aarch64: 'e32ae7fd2669d8729bc6c0dcacbb1b36b33214987df6dd9e57e67cc4b60fe64f',
     armv7l: 'e32ae7fd2669d8729bc6c0dcacbb1b36b33214987df6dd9e57e67cc4b60fe64f',
       i686: 'ccebd02eaa4bba1142b9994196c464652b2fc8af484a64976f92697b7d9d86ab',
     x86_64: 'caf2ef47317736ecf68a68f00e3bc10e4d33e4e734698047d612c337b844f856'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
