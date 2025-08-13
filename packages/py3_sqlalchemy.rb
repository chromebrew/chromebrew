require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.0.43-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ac8a1bb8ff41ca17484c6404ee54deb4e03093fade16d861cb015a9030827a86',
     armv7l: 'ac8a1bb8ff41ca17484c6404ee54deb4e03093fade16d861cb015a9030827a86',
       i686: '241580ef8336c1c1c3a5e8541919648428db8353c4e81ca4c7d0ee4271272a39',
     x86_64: '3421a4be90f6b1c00e8e5429169a1457db592cc6ef1822206e704c675b4fa229'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
