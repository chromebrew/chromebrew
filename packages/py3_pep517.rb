require 'buildsystems/pip'

class Py3_pep517 < Pip
  description 'Python PEP517 is an API to call PEP 517 hooks for building Python packages '
  homepage 'https://pep517.readthedocs.io/'
  version "0.13.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c51509b73857ef343fe8719492caf72dda1b316c5baa18051095cd8b2083bb41',
     armv7l: 'c51509b73857ef343fe8719492caf72dda1b316c5baa18051095cd8b2083bb41',
       i686: '58effc349a8d3e02e8e4469803c2fac40a114ae5d274b9cb603750797669240d',
     x86_64: '97e1e52fee8b729abdc65f97f82882f097944ef2788697bcb272fea1d2a66c7e'
  })

  depends_on 'python3'
  depends_on 'py3_tomli'

  no_source_build
end
