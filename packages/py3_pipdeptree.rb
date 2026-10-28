require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "4.2.10-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bd92a9b47be23bf7b3dda0ce6601d6991d93eb91a05f9f580c56c5a2964a0985',
     armv7l: 'bd92a9b47be23bf7b3dda0ce6601d6991d93eb91a05f9f580c56c5a2964a0985',
       i686: 'b4e2a42025882bc42c9b60f97ae327e4579ee882f15e5828c8e7bac914c4d4fe',
     x86_64: '9378df1e45568dadf30f62673b91c92d64cdb52b24102d23bc686f11c9dab6f7'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
