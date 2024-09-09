require 'buildsystems/pip'

class Py3_pybind11 < Pip
  description 'Seamless operability between C++11 and Python'
  homepage 'https://github.com/pybind/pybind11'
  version '2.13.5-py3.12'
  license 'BSD-3 Clause'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3'

  no_source_build
end
