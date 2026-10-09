require 'buildsystems/pip'

class Py3_id < Pip
  description 'Python tool for generating OIDC identities.'
  homepage 'https://pypi.org/project/id'
  version "1.6.1-#{CREW_PY_VER}"
  license 'Apache'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bb3689cf078d1bfd87bb1f1cb70e5a18c82a04fa34259b80754f9638ab2ea079',
     armv7l: 'bb3689cf078d1bfd87bb1f1cb70e5a18c82a04fa34259b80754f9638ab2ea079',
       i686: '8c0e1c9fad4c9f30328b894e83d69cee49b367d10184650c0f2892f92eed3873',
     x86_64: 'e791fdb3faf22fb8107ab07a34f32acc479c292642865ccea58909ad44bc58ed'
  })

  depends_on 'python3' => :logical

  no_source_build
end
