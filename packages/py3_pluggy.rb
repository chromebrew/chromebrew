require 'buildsystems/pip'

class Py3_pluggy < Pip
  description 'Pluggy provides plugin and hook calling mechanisms for Python.'
  homepage 'https://pluggy.readthedocs.io/'
  version '1.5.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_source_build
end
