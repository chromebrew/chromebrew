require 'buildsystems/pip'

class Py3_id < Pip
  description 'Python tool for generating OIDC identities.'
  homepage 'https://pypi.org/project/id'
  version "1.5.0-#{CREW_PY_VER}"
  license 'Apache'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '879b567e835623ec3058eb8f66167af042f134cf66b0916e30eed2e5a7de4ded',
     armv7l: '879b567e835623ec3058eb8f66167af042f134cf66b0916e30eed2e5a7de4ded',
       i686: '57aecb22a4e0ed89eb7be9bccc551eb19f2bebba8c33b6082be841e080ae2ed0',
     x86_64: '67a495aae268b614aecba416122b36d41a1761ad43278faef9ca259bddf5ee85'
  })

  depends_on 'python3' => :build

  no_source_build
end
