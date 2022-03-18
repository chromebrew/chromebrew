require 'package'

class Exa < Package
  description 'Modern replacement for \'ls\''
  homepage 'https://the.exa.website'
  @_ver = '0.10.1'
  version @_ver
  license 'Apache-2.0, MIT and Unlicense'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://github.com/ogham/exa.git'
  git_hashtag 'v' + @_ver

  depends_on 'rust' => :build
  depends_on 'libgit2'

  def self.build
    system 'cargo build --release -v'
  end

  def self.check
    system 'cargo test --all'
  end

  def self.install
    system "install -Dm755 target/release/exa #{CREW_DEST_PREFIX}/bin/exa"
  end
end
