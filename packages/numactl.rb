require 'buildsystems/autotools'

class Numactl < Autotools
  description 'NUMA support for Linux'
  homepage 'https://github.com/numactl/numactl'
  version '2.0.19'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://github.com/numactl/numactl/releases/download/v#{version}/numactl-#{version}.tar.gz"
  source_sha256 'f2672a0381cb59196e9c246bf8bcc43d5568bc457700a697f1a1df762b9af884'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '67e590c182e42b5faa326cc73e6051b7318ef59761f0e2992e1aeb90de5e9ce0',
     armv7l: '67e590c182e42b5faa326cc73e6051b7318ef59761f0e2992e1aeb90de5e9ce0',
       i686: 'adafc7b58e91819d4ea23640d21e90706e91aa901fb462cc9e2910b40105c574',
     x86_64: '039c473572db8629ff3c6f57c3030b718607433657eb85395e6890cd7878e4c4'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  conflicts_ok # ["manpages:/usr/local/share/man/man2/move_pages.2.zst"]
end
