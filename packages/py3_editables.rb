require 'buildsystems/pip'

class Py3_editables < Pip
  description 'A Python library for creating "editable wheels"'
  homepage 'https://editables.readthedocs.io'
  version "0.6-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5945a15518cb7c01f4d57bae774c75cdfe222542003780b63176595438dc4965',
     armv7l: '5945a15518cb7c01f4d57bae774c75cdfe222542003780b63176595438dc4965',
       i686: 'fb61e5f660dce04a474f31824b261161d1fce4bc770aaa9eadb9ef2955cbfcfa',
     x86_64: '344c95e71a9d0650ecde8f8e55985bb6f221cda57b2f4b1fe1a0fedcaf105c92'
  })

  depends_on 'python3' => :logical

  no_source_build
end
