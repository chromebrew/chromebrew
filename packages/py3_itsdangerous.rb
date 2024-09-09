require 'buildsystems/pip'

class Py3_itsdangerous < Pip
  description 'ItsDangerous provide various helpers to pass data to untrusted environments and back.'
  homepage 'https://palletsprojects.com/p/itsdangerous/'
  version '2.2.0-py3.12'
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_source_build
end
