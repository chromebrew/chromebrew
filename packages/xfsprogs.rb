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
    aarch64: '4a9a975433292c7dd476b8360e108b1940fe5297ae78d5dbb45f138a802fea9c',
     armv7l: '4a9a975433292c7dd476b8360e108b1940fe5297ae78d5dbb45f138a802fea9c',
     x86_64: 'efa3d82c73b8b2fc2128cc70dd6b64420a83ef119e227dfec21e4b7343e846ed'
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
  autotools_install_extras do
    system "make DESTDIR=#{CREW_DEST_DIR} install-dev"
  end
end
