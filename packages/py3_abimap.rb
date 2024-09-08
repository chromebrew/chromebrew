require 'buildsystems/pip'

class Py3_abimap < Pip
  description 'A helper for library maintainers to use symbol versioning'
  homepage 'https://github.com/ansasaki/abimap'
  version '0.3.2-py3.12'
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  depends_on 'python3' => :build
end
