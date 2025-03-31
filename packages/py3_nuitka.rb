require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.6.9-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2ff974da97903ad395fed9a42cde43a5868b80a3032cd4ffc2b9e2a68f260cc4',
     armv7l: '2ff974da97903ad395fed9a42cde43a5868b80a3032cd4ffc2b9e2a68f260cc4',
       i686: '542ae61f80335302fd8714cea275c79a9b6e4107466778c525eb24bd40f43e80',
     x86_64: '28363329412cd93fca8eb394897e3a6018246580074a05028954b0a393a9cd1f'
  })

  depends_on 'python3' => :build

  no_source_build
end
