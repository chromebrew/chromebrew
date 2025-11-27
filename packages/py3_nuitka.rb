require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.8.8-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '47e58c8ebc54c3dea851ba21cd5beb94b7bb415665d378e77b173ddb80adf8b8',
     armv7l: '47e58c8ebc54c3dea851ba21cd5beb94b7bb415665d378e77b173ddb80adf8b8',
       i686: '2690ab59322288e3e172d8b4ffa2d63597451fe1a4216f8992bf124dbb98932d',
     x86_64: '0a4b914a9b9818278801e93d338a8d79e719c7332f53aecfa45eef1fd367eb8b'
  })

  depends_on 'python3' => :build

  no_source_build
end
