require 'buildsystems/perl'

class Perl_percona_toolkit < PERL
  description 'Percona Toolkit is a collection of advanced command-line tools used by Percona support staff to perform a variety of MySQL and system tasks that are too difficult or complex to perform manually.'
  homepage 'https://www.percona.com/percona-toolkit'
  version '3.7.2'
  license 'GPL-2'
  compatibility 'x86_64'
  source_url 'https://github.com/percona/percona-toolkit.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '2fe118ac761a8e7ff3f7cfda2152c5b97ca81167c16d14ab777e2b66f1e28e69'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build
  depends_on 'mysql'
  depends_on 'perl'
  depends_on 'perl' => :logical
end
