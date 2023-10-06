require 'buildsystems/pip'

class Py3_mock < Pip
  description 'Mock is a testing library in Python.'
  homepage 'https://mock.readthedocs.org/'
  @_ver = '4.0.3'
  version "#{@_ver}-py3.12"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({})
  binary_sha256({})
end
