require 'buildsystems/autotools'

class Automake < Autotools
  description 'Automake is a tool for automatically generating Makefile.in files compliant with the GNU Coding Standards.'
  homepage 'https://www.gnu.org/software/automake/'
  version '1.19'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://https.git.savannah.gnu.org/git/automake.git'
  git_hashtag "v#{version}"
  # source_url "https://ftp.gnu.org/gnu/gnu/automake/automake-#{version}.tar.xz"
  # source_sha256 '5bdccca96b007a7e344c24204b9b9ac12ecd17f5971931a9063bdee4887f4aaf'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7326f3447ea17c6e7c051a1d10f481390f90299da365364b98b8f16ea4237c63',
     armv7l: '7326f3447ea17c6e7c051a1d10f481390f90299da365364b98b8f16ea4237c63',
       i686: 'fdebb39071b1397c8f6e55686705997485e36f3f7ef4625c89c29e50f8c8cbc0',
     x86_64: 'fa15d8f9806d629926e16689511c2e6e429325f1d289df17d5b00d79ae104fb0'
  })

  depends_on 'autoconf'

  no_filefix

  autotools_configure_options '--disable-option-checking'
end
