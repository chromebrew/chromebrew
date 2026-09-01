require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "4.2.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2212b067a321d6f674ee26d3d8699b540bf2aced75d2b1f2ed94b00478718d83',
     armv7l: '2212b067a321d6f674ee26d3d8699b540bf2aced75d2b1f2ed94b00478718d83',
       i686: 'ffb65243d4045559ddc010dcb35b6ca5fbb6289cb40867574ab122495e96b59e',
     x86_64: '7335c608b0ea64fe2a3a008720eba48222b9a24e0bbcb3cf3a4539720830e4ef'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
