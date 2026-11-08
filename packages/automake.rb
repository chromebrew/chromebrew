require 'buildsystems/autotools'

class Automake < Autotools
  description 'Automake is a tool for automatically generating Makefile.in files compliant with the GNU Coding Standards.'
  homepage 'https://www.gnu.org/software/automake/'
  version '1.20'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://https.git.savannah.gnu.org/git/automake.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f511ae72f7b403ac04681baed501366a9746684b683120c9dc4ed60c800015f3',
     armv7l: 'f511ae72f7b403ac04681baed501366a9746684b683120c9dc4ed60c800015f3',
       i686: 'b808392f72e9aa49ec4d833583b8d31a63a194418984e7df25b2a53ef709abd1',
     x86_64: 'b5822e67b6990f90fad90644f2ab63a7b8badd8cedd1ef24f66c244814d39b45'
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
