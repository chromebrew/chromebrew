require 'buildsystems/autotools'

class Sed < Autotools
  description 'sed (stream editor) is a non-interactive command-line text editor.'
  homepage 'https://www.gnu.org/software/sed/'
  version '4.10'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/sed.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4362a8a474cea08d6f9ca254a913334daef865c7a735083d895d09c18faf08e2',
     armv7l: '4362a8a474cea08d6f9ca254a913334daef865c7a735083d895d09c18faf08e2',
       i686: '50c33a1f68aab08347f875b2a4441a36a381e01f683eff58bd6f052a6b8c8c89',
     x86_64: 'efb63f2a8935789bdffc0e37978fd5c878996833e28d177a49716dead83e2382'
  })

  depends_on 'acl' => :executable
  depends_on 'attr' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'wget2' => :build

  autotools_skip_autoreconf
  autotools_configure_options '--without-selinux \
                               --enable-gcc-warnings=no'
end
