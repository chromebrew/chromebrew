require 'buildsystems/autotools'

class Babeltrace < Autotools
  description 'open-source trace manipulation toolkit.'
  homepage 'https://babeltrace.org/'
  version '2.1.2'
  license 'MIT, BSD-2-Clause, BSD-4-Clause, LGPL-2.1, GPL-2+, PSF-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.efficios.com/files/babeltrace/babeltrace2-#{version}.tar.bz2"
  source_sha256 '87ff9d801cb11969181d5b8cf8b65e65e5b24bb0c76a1b825e8098f2906fbdf4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '12c28104a5e1d59e4c0836c3fc3cd67ef85aa6e4cbfed7f92ea1aeee4da8c13e',
     armv7l: '12c28104a5e1d59e4c0836c3fc3cd67ef85aa6e4cbfed7f92ea1aeee4da8c13e',
     x86_64: '5cc042598cb908723ad594c7fd755e96f498d94e8a3b81a4f3b491fdc7775a77'
  })

  depends_on 'elfutils' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  run_tests
end
