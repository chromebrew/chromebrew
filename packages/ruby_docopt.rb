require 'package'

class Ruby_docopt < Package
  description 'Docopt parses command line arguments from nothing more than a usage message.'
  homepage 'http://docopt.org/'
  version '0.6.1-ruby-3.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/docopt/docopt.rb.git'
  git_hashtag '794c47d7cb62ca71d65086623a55881449bc2f9e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_docopt/0.6.1-ruby-3.2_armv7l/ruby_docopt-0.6.1-ruby-3.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_docopt/0.6.1-ruby-3.2_armv7l/ruby_docopt-0.6.1-ruby-3.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_docopt/0.6.1-ruby-3.2_i686/ruby_docopt-0.6.1-ruby-3.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_docopt/0.6.1-ruby-3.2_x86_64/ruby_docopt-0.6.1-ruby-3.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '000ed79c3a74b398ed6ec9274ecf0e5e1723d59e3b31268a90247502d53bad53',
     armv7l: '000ed79c3a74b398ed6ec9274ecf0e5e1723d59e3b31268a90247502d53bad53',
       i686: 'fb17d5b96d5646285e7dacdbcedb48746f868ba1f599032231ce4f7ca22eb1c9',
     x86_64: '4e9984e4ab3f456f7a4dcd912d6ad32e10ef53a147a2631890aea8a8dbb18f7d'
  })

  depends_on 'libyaml'
  depends_on 'ruby'

  def self.build
    system 'rake build'
  end

  def self.install
    system "gem install --build=#{CREW_DEST_DIR} pkg/docopt-0.6.1.gem"
  end
end
