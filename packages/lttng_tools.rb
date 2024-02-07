require 'buildsystems/autotools'

class Lttng_tools < Autotools
  description 'Linux Trace Toolkit: next generation is a modern toolkit for tracing Linux systems and applications.'
  homepage 'https://lttng.org/'
  version '2.13.11'
  license 'LGPL-2.1-only, MIT, GPL-2.0-only, GPL-3.0-or-later, BSD-2-Clause, BSD-3-Clause'
  compatibility 'all'
  source_url 'https://lttng.org/files/lttng-tools/lttng-tools-2.13.11.tar.bz2'
  source_sha256 'ac5baeef9fa690936b1ca01ecd1742da762c2c08511ff1b4e923938d94d0f979'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '858bf46965fdddc915b95399b00d2e5f6c8f0e7f98c9023489032d05d58a8006',
     armv7l: '858bf46965fdddc915b95399b00d2e5f6c8f0e7f98c9023489032d05d58a8006',
       i686: 'a42d6fb71ecaf14685c8ed8ca6113659a2273715b4de5e48f599880fa67bf9ab',
     x86_64: 'dad4ae44ea2566f3e915e3669f61d195f6bc8ece0f3211426be1e726e94ae913'
  })

  depends_on 'lttng_ust'
  depends_on 'libkmod'
end
