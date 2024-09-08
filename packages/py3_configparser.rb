require 'buildsystems/pip'

class Py3_configparser < Pip
  description 'Configparser backports newer configparser modules to earlier python versions.'
  homepage 'https://github.com/jaraco/configparser/'
  version '7.1.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed
end
