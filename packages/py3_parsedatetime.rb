require 'buildsystems/pip'

class Py3_parsedatetime < Pip
  description 'Parse human-readable date/time strings'
  homepage 'https://github.com/bear/parsedatetime/'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  depends_on 'python3' => :build
end
