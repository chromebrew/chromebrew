require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/benediktschmitt/py-filelock/'
  version "3.21.2-#{CREW_PY_VER}"
  license 'Unlicense'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dfa765ff352d43aaed072333fca6a8ec46972d0a2afb95e47373210dd0f2011b',
     armv7l: 'dfa765ff352d43aaed072333fca6a8ec46972d0a2afb95e47373210dd0f2011b',
       i686: 'c547fcd691fd4b3bd2578db97307285936fd5f50581083423ea72f41b6b30c48',
     x86_64: '44bd9d7b27d0b495be2720f58eb656586031b5c4d27f2ca24147ed5239a277c1'
  })

  depends_on 'python3' => :build

  no_source_build
end
