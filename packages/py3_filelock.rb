require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "4.3.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e07275a0d4b2c48c79a63bddac5372ffdec45064049c3fdc685511fadabf07ad',
     armv7l: 'e07275a0d4b2c48c79a63bddac5372ffdec45064049c3fdc685511fadabf07ad',
       i686: 'd3bc4409fbba2fb328f6fa230b5630c910d38e05e8a3f64d8d729ac67dfa5268',
     x86_64: '9265eb99b124e7ec9d9136af8739e6ab260e1f3e37cddd5c07d37931aa50700d'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
