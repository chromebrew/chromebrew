require 'package'

class Percona_toolkit < Package
  description 'Percona Toolkit is a collection of advanced command-line tools used by Percona support staff to perform a variety of MySQL and system tasks that are too difficult or complex to perform manually.'
  homepage 'https://www.percona.com/percona-toolkit'
  version '3.6.0'
  license 'GPL-2'
  compatibility 'x86_64'
  source_url 'https://github.com/percona/percona-toolkit.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '62753c68c0bfe391c1a49e0e0dfcf924b142bb8afe7693b529aac30e67df2dcf'
  })

  depends_on 'go' => :build
  depends_on 'mysql'
  depends_on 'perl'

  def self.build
    system "perl Makefile.PL PREFIX=#{CREW_PREFIX}"
    system 'make'
  end

  def self.check
    system 'make', 'test'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
