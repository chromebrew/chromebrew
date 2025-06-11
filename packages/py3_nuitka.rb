require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.7.7-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2dab495205842f63572034e7bf694befdae077325747be55d167ff3c066c7899',
     armv7l: '2dab495205842f63572034e7bf694befdae077325747be55d167ff3c066c7899',
       i686: '2b6d66d80aa1763a825f85c977d43a3e51aeff7619ebbf9c542235acc15d1cf7',
     x86_64: 'a4f0882e55f7df44bfa81ffae7134272b55db983061d406193e633195698237c'
  })

  depends_on 'python3' => :build

  no_source_build
end
