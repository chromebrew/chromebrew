require 'buildsystems/autotools'

class Libsigsegv < Autotools
  description 'GNU libsigsegv is a library for handling page faults in user mode.'
  homepage 'https://www.gnu.org/software/libsigsegv/'
  version '2.15'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/libsigsegv.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e499238dcfc3cd52b1540ab9672b924c190ec374ba077cd70f0b0cc62485469b',
     armv7l: 'e499238dcfc3cd52b1540ab9672b924c190ec374ba077cd70f0b0cc62485469b',
       i686: 'c1d26aad638486c0d2f0a6dd470c31189f7c07c846a6b97bd7f87cf2d9492154',
     x86_64: '1b56f3ef877e3e8962a5b4d42c80f2b5a456a252f6e435d81b0159c59c50bb71'
  })

  depends_on 'glibc' # R

  autotools_configure_options '--enable-shared \
    --enable-static \
    --enable-relocatable'

  def self.patch
    system './gitsub.sh pull'
  end
end
