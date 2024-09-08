require 'buildsystems/pip'

class Py3_argparse_manpage < Pip
  description 'Automatically build man-pages for your Python project.'
  homepage 'https://github.com/praiskup/argparse-manpage'
  version '4.6-py3.12'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'


  depends_on 'python3'
end
