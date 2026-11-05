require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "4.2.9-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aa1f47f140e8c7588ead674dbdd739bfe99f6cfa0c30c6f97fda26a3e389fea8',
     armv7l: 'aa1f47f140e8c7588ead674dbdd739bfe99f6cfa0c30c6f97fda26a3e389fea8',
       i686: 'd52b533de2f3eddf1e8cbb20d668ed465cdeffaac414c976133cf88c1b15751f',
     x86_64: 'd268d1237051f5174332871d35f23f535d5b4ad69f649d94a80a9bddc26b3540'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
