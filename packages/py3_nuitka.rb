require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  @_ver = '0.6.18.5'
  version "#{@_ver}-py3.12"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  source_sha256 'a9c7b49d0bd6ae73fe299772b0f2ae95e6d5d9a20de128932bcc5b92826f0ea7'

  binary_url({})
  binary_sha256({})

  depends_on 'python3' => :build
end
