require 'buildsystems/pip'

class Py3_wcwidth < Pip
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  version "0.5.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6f2878089402978eec941df2688c747f290477c7c0e57b85a5b86ee443a97ad2',
     armv7l: '6f2878089402978eec941df2688c747f290477c7c0e57b85a5b86ee443a97ad2',
       i686: '88744cfbf52cb6797addc2bdd6c2b60413918faa0d40a7289ab332111222dc75',
     x86_64: '34b81274f5bdae6d4c2db90971bc45cb77bb5b9dee66a1890c186de087fcf8f7'
  })

  depends_on 'python3' => :build

  no_source_build
end
