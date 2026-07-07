require 'buildsystems/autotools'

class Mcelog < Autotools
  description 'logs and accounts machine checks (in particular memory, IO, and CPU hardware errors) on modern x86 Linux systems.'
  homepage 'https://www.mcelog.org/'
  version '211'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://git.kernel.org/pub/scm/utils/cpu/mce/mcelog.git/snapshot/mcelog-#{version}.tar.gz"
  source_sha256 '744322b5154ce657758afd942a1fa7bf55879ae618c9274c67dd9333389c6b4f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8be990e99eb8d9e320d464ec947aa3c64cc09cf59e3852d564780b2a004a45a3',
     armv7l: '8be990e99eb8d9e320d464ec947aa3c64cc09cf59e3852d564780b2a004a45a3',
       i686: '4f7dc5cda84cd1ac0c4eff7d65ec11a7333f58119553fcb13c5c5af997428908',
     x86_64: '25b38ae4729a717277a46f738fffc7a37425eb613fcad7ba26dbfc9414404503'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  def self.patch
    system "sed -i 's,prefix := /usr,prefix := #{CREW_PREFIX},' Makefile"
    system "sed -i 's,etcprefix :=,etcprefix := #{CREW_PREFIX},' Makefile"
  end

  autotools_skip_configure
end
