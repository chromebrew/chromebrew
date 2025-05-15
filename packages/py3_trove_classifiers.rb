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
    aarch64: 'd4bf7443f83ea256d878295223ea17db8e6ec0b42a870cfa0eb5acd799f747cb',
     armv7l: 'd4bf7443f83ea256d878295223ea17db8e6ec0b42a870cfa0eb5acd799f747cb',
       i686: '3e6b3dc100d2aba3ca32fbdf4dae25d80a79d1f2fd9816c531c7c4995c600f6a',
     x86_64: '89bdee54749938af7651093412ffaede098110b491d60c3bd7892ebae076ef92'
  })

  depends_on 'python3' => :build

  no_source_build
end
