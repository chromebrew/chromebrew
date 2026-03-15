require 'buildsystems/autotools'

class Fossil < Autotools
  description 'Fossil is a simple, high-reliability, distributed software configuration management system'
  homepage 'https://fossil-scm.org/home/doc/trunk/www/index.wiki'
  version '2.28'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/drhsqlite/fossil-mirror.git'
  git_hashtag "version-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1a0f7180eb3a164dc90872d99e168d233f442ffb34c3eaee35fb0ab637d99ea9',
     armv7l: '1a0f7180eb3a164dc90872d99e168d233f442ffb34c3eaee35fb0ab637d99ea9',
       i686: 'f8ac9ec86f7163eccda5f3092cef384a1c96203c9920a43246f3324fff174574',
     x86_64: '90ff6bc93846c2d7416f86320929898a38d46c356b47fd18d75db3bf8577f411'
  })

  # Error: system SQLite library omits required build option -DSQLITE_ENABLE_DBSTAT_VTAB
  depends_on 'fuse2'
  depends_on 'fuse2' => :executable_only
  depends_on 'glibc' => :executable_only
  depends_on 'openssl' => :executable_only
  # depends_on 'sqlite'
  depends_on 'tcl' => :build
  depends_on 'zlib' => :executable_only

  # Fossil uses autosetup, which behaves enough like autotools that if we only pass certain options,
  # we can still use the rest of the autotools buildsystem.

  autotools_install_extras do
    FileUtils.install 'fossil.1', "#{CREW_DEST_MAN_PREFIX}/man1/fossil.1", mode: 0o644
  end
end
