require 'buildsystems/autotools'

class Ndisc6 < Autotools
  description 'Small collection of useful tools for IPv6 networking (ndisc6, rdisc6, tcptraceroute6, traceroute6, rdnssd).'
  homepage 'https://www.remlab.net/ndisc6/'
  version '1.0.8'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://www.remlab.net/files/ndisc6/ndisc6-#{version}.tar.bz2"
  source_sha256 '1f2fb2dc1172770aa5a09d39738a44d8b753cc5e2e25e306ca78682f9fea0b4f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '18e22de4da573e25a38c5dd108a4121e45278129b90bc6faee91a41c666d538d',
     armv7l: '18e22de4da573e25a38c5dd108a4121e45278129b90bc6faee91a41c666d538d',
       i686: '9bcdc5cee50c6cc0023226ae9c5a0628861650ef7b99788362c8de15e68fe610',
     x86_64: '4903331acbaefa2f66db1514c08ee5b614508432d2b1fbe21a0392191020c099'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  autotools_configure_options '--disable-suid-install'
end
