require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "4.2.13-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a893eb17a46ee3d2d3b4b1868dd33b3db2964496f2280e2a7f28dbf752024260',
     armv7l: 'a893eb17a46ee3d2d3b4b1868dd33b3db2964496f2280e2a7f28dbf752024260',
       i686: '76c7450a8020b6758f1a228ea300e7ba7a3ddb1691f4b4b207d279e7bb9b871f',
     x86_64: 'cdfba0dc82551ac902f3a1331189c6f43b66e09644cc7ad907fa551c74637799'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
