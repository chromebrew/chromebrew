require 'package'

class Ledger < Package
  description 'A double-entry accounting system with a command-line reporting interface'
  homepage 'https://www.ledger-cli.org/'
  version '3.2.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/ledger/ledger.git'
  git_hashtag "v#{version}"

  depends_on 'boost' => :build

  def self.build
    system './acprep', "--prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install/strip'
  end
end
