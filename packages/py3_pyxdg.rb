require 'buildsystems/pip'

class Py3_pyxdg < Pip
  description 'PyXDG contains implementations of freedesktop.org standards in python.'
  homepage 'https://freedesktop.org/wiki/Software/pyxdg/'
  version "0.28-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '574f437ab510fd02b93d91836da978f82ef99e6956cadf70d66aa084664f0606',
     armv7l: '574f437ab510fd02b93d91836da978f82ef99e6956cadf70d66aa084664f0606',
       i686: '10a5d28eb98eedb2de8ade584abb29b8044d99d0d2bfa82cbfbc8d9cae7390bb',
     x86_64: 'f5c75a45fe010c8af2a92e08edb3d41733158c62d3f606e8dbdefcbb34162ebf'
  })

  depends_on 'python3' => :logical

  no_source_build
end
