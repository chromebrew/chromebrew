require 'buildsystems/pip'

class Py3_markdown < Pip
  description 'Markdown is a Python implementation of Markdown.'
  homepage 'https://python-markdown.github.io/'
  version "3.8.2-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ec635c7f7111c436ecccc2efc1237a6d19d6f56454090209ba284161ce83fb60',
     armv7l: 'ec635c7f7111c436ecccc2efc1237a6d19d6f56454090209ba284161ce83fb60',
       i686: 'fd971bb658a84cdedc22a37f868db9b086a3366828c8f8cfad6a34b08f824282',
     x86_64: 'c70961c946d7bb34bef8eda1f9349c46fa970657ccbdc9522671551939708dcd'
  })

  depends_on 'python3'

  no_source_build
end
