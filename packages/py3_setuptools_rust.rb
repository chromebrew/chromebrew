require 'buildsystems/pip'

class Py3_setuptools_rust < Pip
  description 'Setuptools-rust provides rust support for setuptools.'
  homepage 'https://github.com/PyO3/setuptools-rust'
  @_ver = '1.7.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'rust'
  depends_on 'py3_semantic_version'
  depends_on 'python3'

  no_compile_needed
  depends_on 'py3_setuptools_scm' => :build
  depends_on 'py3_typing_extensions' => :build
end
