require 'package'

class Ruby_docopt < Package
  description 'Docopt parses command line arguments from nothing more than a usage message.'
  homepage 'http://docopt.org/'
  version '0.6.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/docopt/docopt.rb.git'
  git_hashtag '504f310c5fd66e9f3c36b078156e5f44573ff1d3'

  depends_on 'ruby'

  def self.patch
    # https://github.com/docopt/docopt.rb/pull/37
    system "sed -i 's:0.6.0:0.6.1:' lib/docopt.rb"
    system "sed -i 's:0.6.0:0.6.1:' docopt.gemspec"
  end

  def self.build
    system 'rake build'
  end

  def self.install
    system "gem install --build=#{CREW_DEST_DIR} pkg/docopt-0.6.1.gem"
  end
end
