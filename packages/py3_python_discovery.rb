require 'buildsystems/pip'

class Py3_python_discovery < Pip
  description 'Python interpreter discovery'
  homepage 'https://github.com/tox-dev/python-discovery'
  version "1.9.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '28f389035427aef513cb62260f0266aee254c0f71ced5ab7577dfb35438879ab',
     armv7l: '28f389035427aef513cb62260f0266aee254c0f71ced5ab7577dfb35438879ab',
       i686: '00f866ac7bc2a0bf7e229070001fcaffdc45db1c455f1d3289fa93ec4d0768ac',
     x86_64: 'b071509694234acc76a4075724423c1651ecc2c0374dc0951dd8fc447c369f27'
  })

  depends_on 'python3' => :logical

  no_source_build
end
