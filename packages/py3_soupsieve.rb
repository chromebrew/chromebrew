require 'buildsystems/pip'

class Py3_soupsieve < Pip
  description 'CSS selector library designed to be used with Beautiful Soup 4.'
  homepage 'https://github.com/facelessuser/soupsieve'
  version "2.7-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '47354580c57347f30e4cd5d869456c918ef6146b0e6a9164cb80b27432fc3db5',
     armv7l: '47354580c57347f30e4cd5d869456c918ef6146b0e6a9164cb80b27432fc3db5',
       i686: '6c2cdc8a9f5a4e2d972041be2769e264e387a0cb027decdb602a957dcd30623c',
     x86_64: '41acfcd5e3727f20c67dcff43af484c88038f32ad99ae3516110152d6c780ff7'
  })

  depends_on 'python3' => :build

  no_source_build
end
