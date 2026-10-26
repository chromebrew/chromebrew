require 'buildsystems/autotools'

class Automake < Autotools
  description 'Automake is a tool for automatically generating Makefile.in files compliant with the GNU Coding Standards.'
  homepage 'https://www.gnu.org/software/automake/'
  version '1.19'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://https.git.savannah.gnu.org/git/automake.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd93174c3b8c4d541fcc5ac97382c6b6d9d864a0988fbea5252dd7cd41340aa9b',
     armv7l: 'd93174c3b8c4d541fcc5ac97382c6b6d9d864a0988fbea5252dd7cd41340aa9b',
       i686: '9ccf1bb4895d4ebf4ff056f11c9cd859fdbfc78a0d105528069a858eb1d166bc',
     x86_64: '03db2521790acb90911f4f178042ed17eafdcdfb079d78912d5d06e4d11d3e7b'
  })

  depends_on 'autoconf' => :executable

  def self.build
    system './bootstrap'
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  autotools_install_extras do
    # Fix aclocal-1: command not found and automake-1: command not found
    FileUtils.ln_s "#{CREW_PREFIX}/bin/aclocal-#{version}", "#{CREW_DEST_PREFIX}/bin/aclocal-1"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/automake-#{version}", "#{CREW_DEST_PREFIX}/bin/automake-1"
  end
end
