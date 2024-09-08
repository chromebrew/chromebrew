require 'buildsystems/pip'

class Py3_unsupported_python < Pip
  version '1.0.0-py3.12'
  homepage 'https://github.com/ntessore/unsupported-python'
  version '1.0.0-py3.12'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'
end
