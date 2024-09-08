require 'buildsystems/pip'

class Py3_retrying < Pip
  description 'Retrying simplifies the task of adding retry behavior to just about anything.'
  homepage 'https://github.com/rholder/retrying/'
  version '1.3.4-py3.12'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_compile_needed
end
