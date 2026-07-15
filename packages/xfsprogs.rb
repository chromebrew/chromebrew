require 'buildsystems/autotools'

class Xfsprogs < Autotools
  description 'XFS filesystem utilities'
  homepage 'https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git/'
  version "7.1.0-#{CREW_ICU_VER}"
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '250602b29ae45c1dbbf7ffd5f25f85ad6c724d14feea7e6bc28b280e74ee12d4',
     armv7l: '250602b29ae45c1dbbf7ffd5f25f85ad6c724d14feea7e6bc28b280e74ee12d4',
     x86_64: '549a45af9656c1f0f640418508cb993af277c8fa31cdb11601a7e45cd88ae84f'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'gettext' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'icu4c' => :executable
  depends_on 'libeconf' => :build
  depends_on 'libinih' => :executable
  depends_on 'liburcu' => :executable
  depends_on 'liburcu' => :library
  depends_on 'lvm2' => :executable
  depends_on 'util_linux' => :executable

  autotools_configure_options '--enable-shared=yes --enable-lto=yes'
  autotools_build_extras do
    # See changes in xfsprogs (5.13.0-1ubuntu1)
    # to handle "so_dot_version does not exist" error.
    # This step has to occur after autoreconf runs.
    FileUtils.cp 'include/install-sh', 'install-sh'
  end
  autotools_install_extras do
    system "make DESTDIR=#{CREW_DEST_DIR} install-dev"
  end
end
