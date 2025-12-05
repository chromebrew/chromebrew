require 'buildsystems/pip'

class Py3_unsupported_python < Pip
  description 'This package can be used as a conditional dependency to indicate lack of support for particular versions of Python.'
  homepage 'https://github.com/ntessore/unsupported-python'
  version "1.0.0-#{CREW_PY_VER}"
  license 'GPL-3+'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed

  pip_pre_configure_options 'ALLOW_UNSUPPORTED_PYTHON=3.12'
end
