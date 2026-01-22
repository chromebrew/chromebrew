require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.0.46-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '10d0a0ca9b6036a8321528fa927c0ced00d6ba83301a2488e9864264f5d72e70',
     armv7l: '10d0a0ca9b6036a8321528fa927c0ced00d6ba83301a2488e9864264f5d72e70',
       i686: '2b8b1902f728eecab806eca0d0c7962c584b5d05033325169a51b9da60ba7ca3',
     x86_64: '9250d0e8addcc5c59c6407d91de5fd7d5037e71d4f09820828f9764c7f78b6c6'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R

  no_source_build
end
