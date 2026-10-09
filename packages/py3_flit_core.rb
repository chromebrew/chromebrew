require 'buildsystems/pip'

class Py3_flit_core < Pip
  description 'Flit provides simplified packaging of Python modules—core portions.'
  homepage 'https://flit.pypa.io/'
  version "4.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '20a2618085de7478e5288de1ed3f01f58c6ae68406019362f23bdc6e3d4a15a1',
     armv7l: '20a2618085de7478e5288de1ed3f01f58c6ae68406019362f23bdc6e3d4a15a1',
       i686: 'fdfb629a3c1a87032bff6d728991c599efddd4da910a9b1c6203d982f878c55a',
     x86_64: 'ce735d5507db966d69b7d0a1aa977062f1c4726465b8dbab12de05ab623e1b88'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
