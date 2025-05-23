require 'buildsystems/autotools'

class Fossil < Autotools
  description 'Fossil is a simple, high-reliability, distributed software configuration management system'
  homepage 'https://fossil-scm.org/home/doc/trunk/www/index.wiki'
  version '2.24'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/drhsqlite/fossil-mirror.git'
  git_hashtag "version-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '269cb46f15dc921144fb041850350096dba8b30b4df7e10911d97040ca9d661a',
     armv7l: '269cb46f15dc921144fb041850350096dba8b30b4df7e10911d97040ca9d661a',
       i686: 'd2ad4dd32e4b12a72b5baa59c0c970dd04e41fa29d2a52f625f0632a38004ad0',
     x86_64: '173b80cd19a31560bb4bae0db994bc14bbcd102d18a6514404963ec93ecb069a'
  })

  depends_on 'fuse2'
  depends_on 'openssl' # R
  # Error: system SQLite library omits required build option -DSQLITE_ENABLE_DBSTAT_VTAB
  # depends_on 'sqlite'
  depends_on 'tcl' => :build
  depends_on 'zlib' # R

  # Fossil uses autosetup, which behaves enough like autotools that if we only pass certain options we can still use the rest of the autotools buildsystem.
  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
  end

  autotools_install_extras do
    FileUtils.install 'fossil.1', "#{CREW_DEST_MAN_PREFIX}/man1/fossil.1", mode: 0o644
  end
end
