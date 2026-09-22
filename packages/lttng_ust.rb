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
    aarch64: '8abc564f183bab9aea7b3ac964158a910b618728cdcfea6c02ebc87950d81ab6',
     armv7l: '8abc564f183bab9aea7b3ac964158a910b618728cdcfea6c02ebc87950d81ab6',
       i686: 'b5591119e085684594d45fd2ff40c41a876e3f45558565ceea147a29144cf049',
     x86_64: '38fd7ace2ba041d476337c403f90678ff773c54e359c455a5063d1c396000d31'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'liburcu' => :library
  depends_on 'numactl' => :library
end
