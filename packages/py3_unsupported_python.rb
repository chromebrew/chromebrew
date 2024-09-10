require 'buildsystems/pip'

class Py3_unsupported_python < Pip
  version '1.0.0-py3.12'
  homepage 'https://github.com/ntessore/unsupported-python'
  version '1.0.0-py3.12'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  depends_on 'python3' => :build

  no_compile_needed

  pre_configure_options 'ALLOW_UNSUPPORTED_PYTHON=3.12'
end
