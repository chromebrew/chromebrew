require 'package'

class Xfsprogs < Package
  description 'XFS filesystem utilities'
  homepage 'https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git/'
  version '6.4.0'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xfsprogs/6.4.0_armv7l/xfsprogs-6.4.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xfsprogs/6.4.0_armv7l/xfsprogs-6.4.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xfsprogs/6.4.0_i686/xfsprogs-6.4.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xfsprogs/6.4.0_x86_64/xfsprogs-6.4.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ffab65dd189d4b258f87241d6e4708767b1af11379238da165f10c07a74e5409',
     armv7l: 'ffab65dd189d4b258f87241d6e4708767b1af11379238da165f10c07a74e5409',
       i686: '480f11957cd44fdbd191c266a4fba5161b3c314428ec4494dcc033aff47c60f1',
     x86_64: '44b56d9763e64846fdf65660813e0cf0d6cab677b1f21b09abc873f26a261f7f'
  })

  depends_on 'gcc_lib' # R
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
