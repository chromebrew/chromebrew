require 'buildsystems/pip'

class Py3_decorator < Pip
  description 'define signature-preserving function decorators and decorator factories'
  homepage 'https://github.com/micheles/decorator/'
  version "5.2.1-#{CREW_PY_VER}"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '58250ef18a200fdfad3863d88718f3160b9a04e5ad38db7c43337fac310421f2',
     armv7l: '58250ef18a200fdfad3863d88718f3160b9a04e5ad38db7c43337fac310421f2',
       i686: '92659dab14f41d00a15d9758a1dc09e7c24c278ea0f85d85509e5c53d97ef0f0',
     x86_64: 'bf9da39cc0eb0144c0ac8fe8474fe5dc70266b62b7e26ba4e0b7d028f17fd3bd'
  })

  depends_on 'python3' => :build

  no_source_build
end
