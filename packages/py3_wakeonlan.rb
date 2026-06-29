require 'buildsystems/pip'

class Py3_wakeonlan < Pip
  description 'A small python module for wake on lan.'
  homepage 'https://pywakeonlan.readthedocs.io/en/latest/'
  version "4.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '194404ee96f0c6baa4a358c6dd870a14d38810b4669a4763b7b90e8e4cc24f15',
     armv7l: '194404ee96f0c6baa4a358c6dd870a14d38810b4669a4763b7b90e8e4cc24f15',
       i686: '88de676aeb5a38020dbab99c3704896ab734b0586bfed4888d1f772b04b2827d',
     x86_64: 'da171717c6996f3493f4574ccfcc4b3fd2cf5bda161070e0d0d535d4e082cb3e'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
