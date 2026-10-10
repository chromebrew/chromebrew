require 'buildsystems/pip'

class Py3_pycparser < Pip
  description 'PyCParser is a complete C99 parser in pure Python.'
  homepage 'https://github.com/eliben/pycparser/'
  version "3.11-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c4756d807cc087f30ad399cf7859181443f0e6f40737091edf3d9e3f60d23af0',
     armv7l: 'c4756d807cc087f30ad399cf7859181443f0e6f40737091edf3d9e3f60d23af0',
       i686: '5b93166ac4de5d706d40bca7290569a30fd03d83a30f4ee2248c3bf6f138e016',
     x86_64: 'fbf7ca7823861e68f5db33f18ffc50926669ac45eaf6d6557df6fc27398c9b29'
  })

  depends_on 'python3' => :logical

  no_source_build
end
