require 'buildsystems/autotools'

class Xfsprogs < Autotools
  description 'XFS filesystem utilities'
  homepage 'https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git/'
  version "6.19.0-1-#{CREW_ICU_VER}"
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cdb8865c13dd9326df4f71fc61b67dc9d22163e517370debecbc07f61070b82b',
     armv7l: 'cdb8865c13dd9326df4f71fc61b67dc9d22163e517370debecbc07f61070b82b',
     x86_64: '892064df76f94452ad4ad97eaf58d47e4ab4200cc6df4b9c1034a5642e3795d0'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'gettext' => :build
  depends_on 'glibc' => :library
  depends_on 'icu4c' => :executable
  depends_on 'libeconf' => :build
  depends_on 'libinih' => :executable
  depends_on 'liburcu' => :executable
  depends_on 'lvm2' => :executable
  depends_on 'util_linux' => :executable

  autotools_configure_options '--enable-shared=yes --enable-lto=yes'
  autotools_build_extras do
    # See changes in xfsprogs (5.13.0-1ubuntu1)
    # to handle "so_dot_version does not exist" error.
    # This step has to occur after autoreconf runs.
    FileUtils.cp 'include/install-sh', 'install-sh'
  end
end
