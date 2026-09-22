require 'buildsystems/autotools'

class Lttng_tools < Autotools
  description 'Linux Trace Toolkit: next generation is a modern toolkit for tracing Linux systems and applications.'
  homepage 'https://lttng.org/'
  version '2.16.0'
  license 'LGPL-2.1-only, MIT, GPL-2.0-only, GPL-3.0-or-later, BSD-2-Clause, BSD-3-Clause'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://lttng.org/files/lttng-tools/lttng-tools-#{version}.tar.bz2"
  source_sha256 'b8b3244894e49e773d4942b8899f768057974edf75c18dbb48b65bb123c7b2c7'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '24e9a7554b75ad3758f12b6a8000fd1966ea7ca809f82a792085f78a1324186e',
     armv7l: '24e9a7554b75ad3758f12b6a8000fd1966ea7ca809f82a792085f78a1324186e',
     x86_64: '13f43b677acb9d0655fdffe94153d4ceeb9b8a7e188cdb0e463786fa0a6e8dc3'
  })

  depends_on 'babeltrace' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libkmod' => :executable
  depends_on 'liburcu' => :library
  depends_on 'libxml2' => :library
  depends_on 'lttng_ust' => :library
  depends_on 'numactl' => :library
  depends_on 'popt' => :executable
end
