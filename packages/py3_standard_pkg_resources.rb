require 'buildsystems/pip'

class Py3_standard_pkg_resources < Pip
  description 'Redistribution of the pkg_resources library provided by setuptools'
  homepage 'https://pypi.org/project/standard-pkg-resources/'
  version "1.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd734954ab7c8f9b4be6dc28d075ef626aab3691d9e8782979abeb664f6b796f6',
     armv7l: 'd734954ab7c8f9b4be6dc28d075ef626aab3691d9e8782979abeb664f6b796f6',
       i686: '6ef8dbf3508416c54149e01e7508af6937e2c3f8aea32a315e000f9852be9eb6',
     x86_64: '46d3887b9bda43dc9d68b03ee186f8e0e5874c8043b5a3b2ac22ba23311c6b7c'
  })

  depends_on 'python3' => :logical

  no_source_build
end
