require 'package'

class Xfsprogs < Package
  description 'XFS filesystem utilities'
  homepage 'https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git/'
  version '6.3.0'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xfsprogs/6.3.0_armv7l/xfsprogs-6.3.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xfsprogs/6.3.0_armv7l/xfsprogs-6.3.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xfsprogs/6.3.0_i686/xfsprogs-6.3.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xfsprogs/6.3.0_x86_64/xfsprogs-6.3.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '022f82d3004a24de58a594be7a04903a2db2bc7740cb1f2baba25b64de688253',
     armv7l: '022f82d3004a24de58a594be7a04903a2db2bc7740cb1f2baba25b64de688253',
       i686: '6fb50807bba01893ea4ae58970fff9b61f6aec7ab80a47ac901af75e54fe65d8',
     x86_64: '48d2e7511699a59e52f224109479503d5a8bdd4f39e05f4b7e0d492436360cf1'
  })

  depends_on 'gcc' # R
  depends_on 'gettext' => :build
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'libinih' # R
  depends_on 'liburcu' # R
  depends_on 'lvm2' # R
  depends_on 'util_linux' # R

  def self.build
    system 'make configure'
    system "DEBUG=-DNDEBUG ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DIST_ROOT=#{CREW_DEST_DIR} install install-dev"
  end
end
