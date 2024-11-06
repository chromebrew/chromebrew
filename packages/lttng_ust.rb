require 'buildsystems/autotools'

class Lttng_ust < Autotools
  description 'Linux Trace Toolkit: next generation is a modern toolkit for tracing Linux systems and applications.'
  homepage 'https://lttng.org/'
  version '2.13.7'
  license 'LGPL-2.1-only, MIT, GPL-2.0-only, GPL-3.0-or-later, BSD-2-Clause, BSD-3-Clause'
  compatibility 'all'
  source_url 'https://lttng.org/files/lttng-ust/lttng-ust-2.13.7.tar.bz2'
  source_sha256 '5fb4f17c307c8c1b79c68561e89be9562d07e7425bf40e728c4d66755342a5eb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1ac688d427738fbb306c05b2296ba7f3046450ebed75ec237b46cf0b7990aabd',
     armv7l: '1ac688d427738fbb306c05b2296ba7f3046450ebed75ec237b46cf0b7990aabd',
       i686: 'd20a9cb55fad688ec847e440a159fcef9654be7004f833dc2b4d0bd80cb54016',
     x86_64: '569a554f0b8a891430547346f75563d0ba77aacd7a48958d543aad7245f17b1b'
  })

  depends_on 'liburcu'
  depends_on 'numactl'
end
