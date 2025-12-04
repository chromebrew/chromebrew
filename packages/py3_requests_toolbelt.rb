require 'buildsystems/pip'

class Py3_requests_toolbelt < Pip
  description 'A collection of utilities for python-requests,'
  homepage 'https://toolbelt.readthedocs.io'
  version "1.0.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '73bf8d06562860290b11e2fd2a9f33870c2f9c5bd40e667aea62e8c7d4d6ff33',
     armv7l: '73bf8d06562860290b11e2fd2a9f33870c2f9c5bd40e667aea62e8c7d4d6ff33',
       i686: '42bc41b34c3034d36dbe9b09bee1717c1b1974bdccaeca2be7213f1a7d0127db',
     x86_64: '71d2c07c31034c4d89edaac3fd82dcb3b78a3e4b6fb1038b45d638e1994cc710'
  })

  depends_on 'py3_requests'
  depends_on 'python3' => :build

  no_source_build
end
