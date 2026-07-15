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
    aarch64: '38e45d54a822f53c3497f6a4cce8a30718d8a98809cd110ef0effdadc570d4ba',
     armv7l: '38e45d54a822f53c3497f6a4cce8a30718d8a98809cd110ef0effdadc570d4ba',
       i686: '48ba80075245b4e962605f8157810b5c094ee528c417e6662dee88fc24fe3b97',
     x86_64: 'c9efb5ff4e1599c44b52daf94f09409ff0eb9f71f75a067b3ef6c336879aad36'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  def self.patch
    system "sed -i 's,prefix := /usr,prefix := #{CREW_PREFIX},' Makefile"
    system "sed -i 's,etcprefix :=,etcprefix := #{CREW_PREFIX},' Makefile"
  end

  autotools_skip_configure
end
