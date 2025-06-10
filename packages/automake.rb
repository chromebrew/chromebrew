require 'buildsystems/autotools'

class Automake < Autotools
  description 'Automake is a tool for automatically generating Makefile.in files compliant with the GNU Coding Standards.'
  homepage 'https://www.gnu.org/software/automake/'
  version '1.18'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://https.git.savannah.gnu.org/git/automake.git'
  git_hashtag "v#{version}"
  # source_url "https://ftpmirror.gnu.org/gnu/automake/automake-#{version}.tar.xz"
  # source_sha256 '5bdccca96b007a7e344c24204b9b9ac12ecd17f5971931a9063bdee4887f4aaf'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'db04372b9e8d82526113ba8daa8fa6f61369cbe6e9b864d0434ed307425870b4',
     armv7l: 'db04372b9e8d82526113ba8daa8fa6f61369cbe6e9b864d0434ed307425870b4',
       i686: '3c25bc262cc5dd27837663fbc92d846e14b111d36ad6e7d707f6d139901f9573',
     x86_64: '350282c323878105d313e018c5695914be1372d61fa65539a5c5765a1a77bdfb'
  })

  depends_on 'autoconf'

  no_filefix

  autotools_configure_options '--disable-option-checking'
end
