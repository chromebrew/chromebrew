require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.16.2-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '84fd807ca774b2a57d29fed32f1a9f390de1e66fe8e80a412314e98960c7847a',
     armv7l: '84fd807ca774b2a57d29fed32f1a9f390de1e66fe8e80a412314e98960c7847a',
       i686: '06be441cdd3154601d31c1f825be2593b502de2c805c229307c4cdb2d518ddb1',
     x86_64: '8c2ca644944baaa3289bc208895e4e3752323cdbad2b2b8998f8af81bc9b1c51'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
