require 'buildsystems/autotools'

class Mcelog < Autotools
  description 'logs and accounts machine checks (in particular memory, IO, and CPU hardware errors) on modern x86 Linux systems.'
  homepage 'https://www.mcelog.org/'
  version '212'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://git.kernel.org/pub/scm/utils/cpu/mce/mcelog.git/snapshot/mcelog-#{version}.tar.gz"
  source_sha256 'c98ede2d06f02c12d272dbb69da63d1f7160751d551664e190a8bb6a9138a206'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '99916977faaf082da9f1b0581b31896fb78d17cd71182a0fb8788849d35bf314',
     armv7l: '99916977faaf082da9f1b0581b31896fb78d17cd71182a0fb8788849d35bf314',
       i686: '539cb26c67b9bdfd2d95c6f5f167656f356f8b7c11b9162ed423e873db64444e',
     x86_64: '49115355e37ea37b00e099f601deddbda3fe794211ac670b6280aae39abfce9e'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  def self.patch
    system "sed -i 's,prefix := /usr,prefix := #{CREW_PREFIX},' Makefile"
    system "sed -i 's,etcprefix :=,etcprefix := #{CREW_PREFIX},' Makefile"
  end

  autotools_skip_configure
end
