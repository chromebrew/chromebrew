require 'buildsystems/autotools'

class Libatomic_ops < Autotools
  description 'Atomic memory update operations portable implementation'
  homepage 'https://github.com/ivmai/libatomic_ops'
  version '7.8.0'
  license 'GPL-2 and all-rights-reserved'
  compatibility 'all'
  source_url 'https://github.com/ivmai/libatomic_ops/releases/download/v7.8.0/libatomic_ops-7.8.0.tar.gz'
  source_sha256 '15676e7674e11bda5a7e50a73f4d9e7d60452271b8acf6fd39a71fefdf89fa31'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '572b3d6d137e8d27703c29dd0e725caa61f5bae11b277433b0491a75a07b269f',
     armv7l: '572b3d6d137e8d27703c29dd0e725caa61f5bae11b277433b0491a75a07b269f',
       i686: 'a4e470d0b2cefac5b21a6c8b14595da362545910ef821903152cb72fc479c7c5',
     x86_64: '478011dfce521a4c33431795b3b24cd13c49cb15c1abd667fcf93e86253ed512'
  })
end
