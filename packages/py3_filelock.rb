require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "4.0.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2abe201fb0a76811bbc35a75c031d8cede5d8b281de47d344af944089ec0d5a2',
     armv7l: '2abe201fb0a76811bbc35a75c031d8cede5d8b281de47d344af944089ec0d5a2',
       i686: '8582c7717e3aecde506037eca3e551b702721196971ac9dfcf9c948086c249b6',
     x86_64: '48ef814d85340547d8600b8a98e1aac85ba22ba7ec3269266fa861c6230e78f9'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
