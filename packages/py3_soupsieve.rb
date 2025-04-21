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
       i686: '5c36704b80defe524e704d194f31a29a494e8b451ab47060c2fd419865b45dda',
     x86_64: '41acfcd5e3727f20c67dcff43af484c88038f32ad99ae3516110152d6c780ff7'
  })

  depends_on 'python3' => :build

  no_source_build
end
