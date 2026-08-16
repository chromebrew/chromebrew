require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "4.2.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b55ce07d2f8ecb50bd22f24acf02ac751e661934738aec40c511ae37b1080017',
     armv7l: 'b55ce07d2f8ecb50bd22f24acf02ac751e661934738aec40c511ae37b1080017',
       i686: '4a3d87c3f737272a640f8155077332d4f273135c50bee3704a46fb68c4e4c3ba',
     x86_64: '3cf0e992e3debf02874cc27defb4f9450d7b37b71c7ef5a4f6920675bc761738'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
