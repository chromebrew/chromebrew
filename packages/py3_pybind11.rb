require 'buildsystems/pip'

class Py3_pybind11 < Pip
  description 'Seamless operability between C++11 and Python'
  homepage 'https://github.com/pybind/pybind11'
  version "3.0.1-#{CREW_PY_VER}"
  license 'BSD-3 Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f4893b568d3a790e2a60bc2c4cecaec7156ea72c94ca0a5621ee62e7bccb312c',
     armv7l: 'f4893b568d3a790e2a60bc2c4cecaec7156ea72c94ca0a5621ee62e7bccb312c',
       i686: '6faad06e6f3500757d36e7e68a9e8af2b0ae87cdac266b631f622bbde8e6bcde',
     x86_64: '3f3543165f48e4db132dc694d35d3cf7a192caf16c6c6e3188d99b9288409b3a'
  })

  depends_on 'python3'

  no_source_build
end
