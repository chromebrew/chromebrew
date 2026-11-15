require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "4.2.14-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '740780191b095db6000f3d5dd4030f7e8773c3bcc2544426b26bfb0c30b3ceb0',
     armv7l: '740780191b095db6000f3d5dd4030f7e8773c3bcc2544426b26bfb0c30b3ceb0',
       i686: '6f1ba1fea6c93f0e41ccfd213d13ddccdb03daf521751860d0fd2efc237d1f66',
     x86_64: 'da3bc5b7d95ad646637dcec8fe394f833bf5f58cfeea24dca3d34bed4ee93457'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
