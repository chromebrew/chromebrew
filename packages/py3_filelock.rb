require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "3.32.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b06436298ab65abb7e8b0eb2c00e0fdcea5808825dd1f127c43d5988963f767e',
     armv7l: 'b06436298ab65abb7e8b0eb2c00e0fdcea5808825dd1f127c43d5988963f767e',
       i686: '579c641bec05b196558846d039437f1dd5774c9ae796e1acf8aad07b279a829b',
     x86_64: 'f3484d345a9d817c39819dd31df7dce87a1090169bc07ab2aceb1c38177900c1'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
