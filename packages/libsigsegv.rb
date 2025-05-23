require 'buildsystems/autotools'

class Libsigsegv < Autotools
  description 'GNU libsigsegv is a library for handling page faults in user mode.'
  homepage 'https://www.gnu.org/software/libsigsegv/'
  version '2.14-a816da0'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/libsigsegv.git'
  git_hashtag 'a816da0ecf6eb59234cdea8e62d0ac5706b714f0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a793b4b5435ef872527a2786e2ec2a60afa477d991971cbef3306294b4e4b158',
     armv7l: 'a793b4b5435ef872527a2786e2ec2a60afa477d991971cbef3306294b4e4b158',
       i686: '66c7fe9e6d8834353140c81a6ddb061a273f07e22bc104584eec90e42f86e9b3',
     x86_64: '937a885c71dbee68b5cdfa5b9a80752d22c581771dcb7d6f8e22ae45e50957f3'
  })

  depends_on 'glibc' # R

  autotools_configure_options '--enable-shared \
    --enable-static \
    --enable-relocatable'

  def self.patch
    system './gitsub.sh pull'
  end
end
