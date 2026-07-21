require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "4.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd8f201dbc94b0b5c95beaeba9d95818fc4e216e1061918ea6c3aa3a0840c3f89',
     armv7l: 'd8f201dbc94b0b5c95beaeba9d95818fc4e216e1061918ea6c3aa3a0840c3f89',
       i686: 'e968c151124d547de90a47e58f2e175f82122ca0cab91af6ac7ae106368a9dc6',
     x86_64: '524d34178150d3067068e251069833a0e70242b6df25ca0bd802c072e1eeb9e5'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
