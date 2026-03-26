require 'buildsystems/autotools'

class Libavc1394 < Autotools
  description 'libavc1394 is a programming interface for the 1394 Trade Association AV/C (Audio/Video Control) Digital Interface Command Set.'
  homepage 'https://sourceforge.net/projects/libavc1394/'
  version '0.5.4'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/libavc1394/libavc1394/libavc1394-#{version}.tar.gz"
  source_sha256 '7cb1ff09506ae911ca9860bef4af08c2403f3e131f6c913a2cbd6ddca4215b53'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '395fb3d835b1a0a284b052fe2b73517c50ca30e1287a8bd12d316ad250c1c121',
     armv7l: '395fb3d835b1a0a284b052fe2b73517c50ca30e1287a8bd12d316ad250c1c121',
       i686: '580942148f6366e81a7a910811a49b5dd8b8ea1acc2a61d833691df1f1a06605',
     x86_64: '06cb06e5364a113ddfb582e58fac8137a944f80d530d376af7248bb1f6f70582'
  })

  depends_on 'glibc' => :library
  depends_on 'libraw1394' => :library

  run_tests
end
