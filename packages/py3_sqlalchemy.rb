require 'buildsystems/python'

class Py3_sqlalchemy < Python
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version '2.0.34-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/sqlalchemy/sqlalchemy.git'
  version '2.0.34-py3.12'
  binary_compression 'tar.zst'

  depends_on 'python3' => :build
  depends_on 'glibc' # R
end
