require 'buildsystems/pip'

class Py3_pytimeparse < Pip
  description 'Pytimeparse is a small Python module to parse various kinds of time expressions. '
  homepage 'https://github.com/wroberts/pytimeparse/'
  version "1.1.10-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b2144a59ad0c6c2a3081db473aad8342feae9781043151dd3d38dda385e35cfd',
     armv7l: 'b2144a59ad0c6c2a3081db473aad8342feae9781043151dd3d38dda385e35cfd',
       i686: '4826ecbd019200371e8813cfc6b91559f73ca713a42a0b6e7afe1542dedd2656',
     x86_64: 'fc5ab2846b819f709a1cf66794ec72c2f2391e937518d62ad6751a33890eb16b'
  })

  depends_on 'python3' => :logical

  no_source_build
end
