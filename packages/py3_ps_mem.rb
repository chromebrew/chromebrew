require 'buildsystems/pip'

class Py3_ps_mem < Pip
  description 'A utility to accurately report the core memory usage for a program'
  homepage 'http://github.com/pixelb/ps_mem'
  version "3.14-#{CREW_PY_VER}"
  license 'LGPLv2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f88fb2f8b7ea31fb12974b1eea67acece0a74e672efd057e56d78dcb8e7d0de9',
     armv7l: 'f88fb2f8b7ea31fb12974b1eea67acece0a74e672efd057e56d78dcb8e7d0de9',
       i686: '5e53f5899f098d0752733ef4f0bb3b5c1d9e1833f3be043357c7b62d5a2537b4',
     x86_64: 'ff441ec429c6365c9194e99bbd14ff1ab3b7ffdda0e5c99e0e4c5cd19f6e54f4'
  })

  depends_on 'python3' => :logical

  no_source_build
end
