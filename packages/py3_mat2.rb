require 'buildsystems/pip'

class Py3_mat2 < Pip
  description 'A handy tool to trash your metadata'
  homepage 'https://0xacab.org/jvoisin/mat2'
  version '0.13.4-py3.12'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'SKIP'

  depends_on 'py3_pycairo' # R
  depends_on 'python3' => :build

  no_compile_needed
end
