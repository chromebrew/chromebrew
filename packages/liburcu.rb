require 'buildsystems/autotools'

class Liburcu < Autotools
  description 'Userspace RCU (read-copy-update) library.'
  homepage 'https://liburcu.org/'
  version '0.15.6'
  license 'LGPLv2.1'
  compatibility 'all'
  source_url "https://lttng.org/files/urcu/userspace-rcu-#{version}.tar.bz2"
  source_sha256 '850b192096eb11ebf2c70e8f97bc7da7479ee41da1bebeb44e3986908bac414f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4fa45616cf52697faa7fc3513ab3d31ecabd61b93ff73ea651e8befda58db4d5',
     armv7l: '4fa45616cf52697faa7fc3513ab3d31ecabd61b93ff73ea651e8befda58db4d5',
       i686: 'f61e50171dc9d59d223049468cadc6e14d663c00e1c2501198ecf6e029566f2f',
     x86_64: '33441ab4a008123e6712d9b8a3b99b4cf1863ff520f853e99afa5b1f3d1ff50e'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  autotools_configure_options '--disable-static'

  run_tests
end
