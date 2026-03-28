require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "2.34.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '005417c92d4db1159babf1fb21be7fa2dabc6d64057ed5c681ddfb2acbd2c65e',
     armv7l: '005417c92d4db1159babf1fb21be7fa2dabc6d64057ed5c681ddfb2acbd2c65e',
       i686: 'eb5cdf58ce767a8b376af84c8ed79ec41d487b4fdc3217c961bae7a8df4cc455',
     x86_64: '1af60212a912cfbe6a6eb8ce8449925b022c330d0e6dd6edb9745a7c8c6b40df'
  })

  depends_on 'python3' => :logical

  no_source_build
end
