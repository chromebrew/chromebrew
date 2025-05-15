require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2025.5.9.12-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2ca900124f956975d9173cf59cc5c9ad44ae61e862c9a6579cde95889b9c4719',
     armv7l: '2ca900124f956975d9173cf59cc5c9ad44ae61e862c9a6579cde95889b9c4719',
       i686: '3e6b3dc100d2aba3ca32fbdf4dae25d80a79d1f2fd9816c531c7c4995c600f6a',
     x86_64: '89bdee54749938af7651093412ffaede098110b491d60c3bd7892ebae076ef92'
  })

  depends_on 'python3' => :build

  no_source_build
end
