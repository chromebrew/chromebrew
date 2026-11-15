require 'buildsystems/autotools'

class Lttng_ust < Autotools
  description 'Linux Trace Toolkit: next generation is a modern toolkit for tracing Linux systems and applications.'
  homepage 'https://lttng.org/'
  version '2.16.0'
  license 'LGPL-2.1-only, MIT, GPL-2.0-only, GPL-3.0-or-later, BSD-2-Clause, BSD-3-Clause'
  compatibility 'all'
  source_url "https://lttng.org/files/lttng-ust/lttng-ust-#{version}.tar.bz2"
  source_sha256 '1e84e02fa1fc1261eb6cf3d14d64006506a29f7c605ac85de02180318c6aa38a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '474bf017c80bec3a8f70979246ed3f100bbcd52eadf3f1c00da88b92bbfb5954',
     armv7l: '474bf017c80bec3a8f70979246ed3f100bbcd52eadf3f1c00da88b92bbfb5954',
       i686: '38cde294975bae73e68161ead1f5b91e47d0f6c94de2593a4eece43a7b22b671',
     x86_64: 'c49698152918adb0b472acc48e564623fe7eae422bb6d5129e43d0b81299a612'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'liburcu' => :library
  depends_on 'numactl' => :library
end
