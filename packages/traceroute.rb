require 'buildsystems/autotools'

class Traceroute < Autotools
  description 'Traceroute tracks the route packets taken from an IP network on their way to a given host.'
  homepage 'https://traceroute.sourceforge.net/'
  version '2.1.6'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/traceroute/traceroute/traceroute-#{version}/traceroute-#{version}.tar.gz"
  source_sha256 '9ccef9cdb9d7a98ff7fbf93f79ebd0e48881664b525c4b232a0fcec7dcb9db5e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f477e37b8f6f5d131bb4dfe97c75dc83c5220f47c9c77575000b6057049dabb3',
     armv7l: 'f477e37b8f6f5d131bb4dfe97c75dc83c5220f47c9c77575000b6057049dabb3',
       i686: 'ac89a0bd94648d7d9f0bc08bfde82bfa3a3ef61850e5fcf7c7f30807da2c5b20',
     x86_64: '99fd85a8ac4381524d6d5636a69c17fcd501313289f97991529a95fc5857a620'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  autotools_skip_configure

  def self.patch
    # add /usr/lib64 to vpath to check /usr/lib64/libm.so
    system 'sed', '-i', 'Make.rules', '-e', '/vpath lib%.so/s:$: /usr/lib64:'
  end
end
