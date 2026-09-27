require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "4.0.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0005cce52ccfd3e4b2bd048bd0463bf6cc56c0b426e26f939ccd6c4be16ef361',
     armv7l: '0005cce52ccfd3e4b2bd048bd0463bf6cc56c0b426e26f939ccd6c4be16ef361',
       i686: 'd7d18e6eccb258dd7076904450af2fc63cf3bc3606a1b074b3dd97e477e9697d',
     x86_64: 'f08a607f112013e47f900d0396a11fe671caffef3f7d8da3b2d9d3542132d3a6'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
