require 'buildsystems/autotools'

class Fossil < Autotools
  description 'Fossil is a simple, high-reliability, distributed software configuration management system'
  homepage 'https://fossil-scm.org/home/doc/trunk/www/index.wiki'
  version '2.27'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/drhsqlite/fossil-mirror.git'
  git_hashtag "version-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd96af524277488356522e3bde93e3971798e091cf2a249c5d35698cb08274da5',
     armv7l: 'd96af524277488356522e3bde93e3971798e091cf2a249c5d35698cb08274da5',
       i686: '28048a4e282dc2d0b8d9e07b50ae5d745dcc125a30203a5aa51d1caf9a563fbe',
     x86_64: 'd03d57a3cb8ae8ca669b8fd6019314c656898ae36943492f4b43162ff6ccdc75'
  })

  # Error: system SQLite library omits required build option -DSQLITE_ENABLE_DBSTAT_VTAB
  # depends_on 'sqlite'
  depends_on 'fuse2'
  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'tcl' => :build
  depends_on 'zlib' # R

  # Fossil uses autosetup, which behaves enough like autotools that if we only pass certain options,
  # we can still use the rest of the autotools buildsystem.

  autotools_install_extras do
    FileUtils.install 'fossil.1', "#{CREW_DEST_MAN_PREFIX}/man1/fossil.1", mode: 0o644
  end
end
