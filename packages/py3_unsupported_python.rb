require 'buildsystems/pip'

class Py3_unsupported_python < Pip
  description 'This package can be used as a conditional dependency to indicate lack of support for particular versions of Python.'
  homepage 'https://github.com/ntessore/unsupported-python'
  @_ver = '1.0.0'
  version "#{@_ver}-py3.12"
  license 'GPL-3+'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({})
  binary_sha256({})

  depends_on 'python3' => :build

  pre_configure_options 'ALLOW_UNSUPPORTED_PYTHON=3.12'
end
