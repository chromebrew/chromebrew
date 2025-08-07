require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2025.8.6.13-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd4bf7443f83ea256d878295223ea17db8e6ec0b42a870cfa0eb5acd799f747cb',
     armv7l: 'd4bf7443f83ea256d878295223ea17db8e6ec0b42a870cfa0eb5acd799f747cb',
       i686: 'd729fbf72fc8b6cc06a6c901cca1f78dcf7381b5b7e6db202e65283a05dec206',
     x86_64: '89bdee54749938af7651093412ffaede098110b491d60c3bd7892ebae076ef92'
  })

  depends_on 'python3' => :build

  no_source_build
end
