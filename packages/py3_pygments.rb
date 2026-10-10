require 'buildsystems/pip'

class Py3_pygments < Pip
  description 'Python Syntax Highlighter'
  homepage 'https://pygments.org/'
  version "2.21.0-#{CREW_PY_VER}"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c92a8f2dd6ecc6c595cd26c76f6c3c1702273cbcf0a9424884320d395ffa18c7',
     armv7l: 'c92a8f2dd6ecc6c595cd26c76f6c3c1702273cbcf0a9424884320d395ffa18c7',
       i686: 'd1ae456bb5fb3f5061cff0e302a3490c103a56c499056f31947e0ae90567ba58',
     x86_64: '73480c23c09e08429d9f6767eee0bfa1fadf5bb6d299964c362429c62d42e3e4'
  })

  depends_on 'python3' => :logical

  no_source_build
end
