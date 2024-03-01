require 'buildsystems/autotools'

class Libsigsegv < Autotools
  description 'GNU libsigsegv is a library for handling page faults in user mode.'
  homepage 'https://www.gnu.org/software/libsigsegv/'
  version '2.14-b3b4eb4'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/libsigsegv.git'
  git_hashtag 'b3b4eb445bf15b96139c4636ef3c5936ae3b988d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bc13bc73318d0d26a86a3a428b5d47374c096ccb9393185674e4d1cebe828426',
     armv7l: 'bc13bc73318d0d26a86a3a428b5d47374c096ccb9393185674e4d1cebe828426',
       i686: '3007d4a94f511be94ea2bda6c9849a6e2c64e5337138328e2bce3927abe9c063',
     x86_64: '819d83c65ead745681bca4b1dcaa6d7c3913f75373bde41d95ce452e9b35efe4'
  })

  depends_on 'glibc' # R

  configure_options '--enable-shared \
    --enable-static \
    --enable-relocatable'
  def self.patch
    system './gitsub.sh pull'
  end
end
