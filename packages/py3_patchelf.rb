require 'buildsystems/pip'

class Py3_patchelf < Pip
  description 'Patchelf is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'https://pypi.org/project/patchelf'
  version "0.19.3.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f36ec92a17dca6abb52f948bc547e9c33c9d7350506b76f1f9db330f066796fd',
     armv7l: 'f36ec92a17dca6abb52f948bc547e9c33c9d7350506b76f1f9db330f066796fd',
       i686: '659e63c609a8a3d0bee129b1de705be6e60144fd6658a16442a7afed8cbd6f2f',
     x86_64: '6571ab77f45564b49e12220fac3c81ea46af1861103a45c84d07bd675ee3b4a2'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'python3'
  depends_on 'python3' => :logical

  conflicts_ok # Conflicts with patchelf.
  no_source_build
end
