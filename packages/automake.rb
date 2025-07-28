require 'buildsystems/autotools'

class Automake < Autotools
  description 'Automake is a tool for automatically generating Makefile.in files compliant with the GNU Coding Standards.'
  homepage 'https://www.gnu.org/software/automake/'
  version '1.18.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://https.git.savannah.gnu.org/git/automake.git'
  git_hashtag "v#{version}"
  # source_url "https://ftpmirror.gnu.org/gnu/automake/automake-#{version}.tar.xz"
  # source_sha256 '5bdccca96b007a7e344c24204b9b9ac12ecd17f5971931a9063bdee4887f4aaf'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dac62cec4062da0ced7e00c53ffaf3809c67d38d3d7342b0ae9ebc5a1b55d30a',
     armv7l: 'dac62cec4062da0ced7e00c53ffaf3809c67d38d3d7342b0ae9ebc5a1b55d30a',
       i686: '3c25bc262cc5dd27837663fbc92d846e14b111d36ad6e7d707f6d139901f9573',
     x86_64: 'f0d23c064d7f7a18a3ef1e7f59b188298c3bd12a5ccf744a554f140f7bf6725c'
  })

  depends_on 'autoconf'

  no_filefix

  autotools_configure_options '--disable-option-checking'
end
