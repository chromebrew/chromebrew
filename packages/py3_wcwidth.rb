require 'buildsystems/pip'

class Py3_wcwidth < Pip
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  version "0.5.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '91837bade46e457db257e2282de9a3cf5cdca95fb63cceed2512cb8313baf727',
     armv7l: '91837bade46e457db257e2282de9a3cf5cdca95fb63cceed2512cb8313baf727',
       i686: 'e50dc88564c9fce5e7c2e0964cbc29180c39d86e022d2c2b594b21f4dcd9b9e7',
     x86_64: '2e913b403cf82e8e676729b8b1f38f49a241155eb1ce4b119329a6d99ee4114d'
  })

  depends_on 'python3' => :build

  no_source_build
end
