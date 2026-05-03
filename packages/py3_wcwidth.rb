require 'buildsystems/pip'

class Py3_wcwidth < Pip
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  version "0.7.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '32d3f3d035ef76bea0be8cb7bbbacd3280170cd426c944d0af1f1936a2db24e8',
     armv7l: '32d3f3d035ef76bea0be8cb7bbbacd3280170cd426c944d0af1f1936a2db24e8',
       i686: 'c9a4b3816f8e791ae9ed69a2eeb71ee2385170839ea4be86a4825889ee7589eb',
     x86_64: '86c2787013730547ea1528afbedf0a89eef015988281f237d2d372f0f2a89aaf'
  })

  depends_on 'python3' => :logical

  no_source_build
end
