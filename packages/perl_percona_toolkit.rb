require 'buildsystems/perl'

class Perl_percona_toolkit < PERL
  description 'Percona Toolkit is a collection of advanced command-line tools used by Percona support staff to perform a variety of MySQL and system tasks that are too difficult or complex to perform manually.'
  homepage 'https://www.percona.com/percona-toolkit'
  version '3.7.1-4'
  license 'GPL-2'
  compatibility 'x86_64'
  source_url 'https://github.com/percona/percona-toolkit.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '85cdefc4310580d904e4af81274d1d5a195ef34dd05260331a413072230f1fe2'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build
  depends_on 'mysql'
  depends_on 'perl'
  depends_on 'perl' => :logical
end
