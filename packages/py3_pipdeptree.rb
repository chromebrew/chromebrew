require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "4.2.16-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c762dad3e765c93fffbf5b3580a99492d41b5c0b9514e1e19db45cbcdcc2f7cd',
     armv7l: 'c762dad3e765c93fffbf5b3580a99492d41b5c0b9514e1e19db45cbcdcc2f7cd',
       i686: '1a0ec43c91f8468b6f1f9e13e1ac75d2cd0f8387aa0d867712cd491ed37923f2',
     x86_64: 'f0e538a6fa21913a46ecf607e1236d565fc22fd4d903b61f01180c403cbcf9af'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
