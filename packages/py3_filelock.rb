require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "4.0.10-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '759119446c96ea420db531af9289a2f62ef712b475f5594a40b5589b54bd2f44',
     armv7l: '759119446c96ea420db531af9289a2f62ef712b475f5594a40b5589b54bd2f44',
       i686: '48a8ce1c7cd3ea701c13131f4018cb58de1c7cb717cf9ed460a4d9dc282c0885',
     x86_64: '22d7d10ac968dd2ac4deb06751c556540feaa258e9d9b2ba6ca3420a2e016873'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
