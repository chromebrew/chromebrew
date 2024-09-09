require 'buildsystems/pip'

class Py3_mock < Pip
  description 'Mock is a testing library in Python.'
  homepage 'https://mock.readthedocs.org/'
  version '5.1.0-py3.12'
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'

  no_source_build
end
