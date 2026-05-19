require 'buildsystems/pip'

class Py3_decorator < Pip
  description 'define signature-preserving function decorators and decorator factories'
  homepage 'https://github.com/micheles/decorator/'
  version "5.3.1-#{CREW_PY_VER}"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6ea9540bedcdbb925782db92a59fad2157c6fd382790babca2175232efd7ebab',
     armv7l: '6ea9540bedcdbb925782db92a59fad2157c6fd382790babca2175232efd7ebab',
       i686: '7b417497e66bb921f8bf601aab11f8ce7ee661e7b157e319f3c36215639c4432',
     x86_64: '7ec9d2247706b5649537c6714833505242f110e49f83b90c1977a76026f6c899'
  })

  depends_on 'python3' => :logical

  no_source_build
end
