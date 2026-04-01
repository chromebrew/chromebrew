require 'buildsystems/pip'

class Py3_pybind11 < Pip
  description 'Seamless operability between C++11 and Python'
  homepage 'https://github.com/pybind/pybind11'
  version "3.0.3-#{CREW_PY_VER}"
  license 'BSD-3 Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '052cbaabbba2b54704d151e4678ed47bb5f2c333ce8e8e29264a3fbb876077f6',
     armv7l: '052cbaabbba2b54704d151e4678ed47bb5f2c333ce8e8e29264a3fbb876077f6',
       i686: '764f3a4a4d7ae6707f931909579c6c0ce9f3810d0d32a8182b5a5b7e001ba2c1',
     x86_64: '486369665fbf56da9b550ceb8f0cde92d5b22cf038405a3899fb0c3473fc6d75'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
