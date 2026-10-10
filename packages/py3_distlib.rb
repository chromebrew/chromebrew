require 'buildsystems/pip'

class Py3_distlib < Pip
  description 'Distlib provides distribution utilities for Python packages.'
  homepage 'https://bitbucket.org/pypa/distlib/'
  version "0.4.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0f4aec50a7ee64a0accf39cb12c5d969e9f1abb26fa0e283644b9e696ee334e8',
     armv7l: '0f4aec50a7ee64a0accf39cb12c5d969e9f1abb26fa0e283644b9e696ee334e8',
       i686: 'da9df2cb111de5e932f52009f703f343ba6f05a168808f6aff99671c78b35e57',
     x86_64: '7f5179aeab1e9bf9903d052400b953758f791b98c1608196b72fcf1646819403'
  })

  depends_on 'python3' => :logical

  no_source_build
end
