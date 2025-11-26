require 'package'

class Chruby < Package
  description 'Changes the current Ruby'
  homepage 'https://github.com/postmodern/chruby'
  version '0.3.9'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/postmodern/chruby.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4e6a622e15f48a5353882b960e9f7d5e1a31302eff337cc3172f0deb23a48d64',
     armv7l: '4e6a622e15f48a5353882b960e9f7d5e1a31302eff337cc3172f0deb23a48d64',
       i686: '1ea85177b7795cefaad7aa7ccdc135b4842c8c59921e137c7dd514f2972a6c84',
     x86_64: 'f3ca77a21c312d9451c23738a75449b66a3072befcd0f16d3eae7e2942238baf'
  })

  def self.build
    system 'make'
  end

  # Tests fail with "!!! Could not detect system name"
  # This is because the test setup script requires that it identifies the distribution it is running on, and does not have a check for ChromeOS.
  # In the current upstrem tree, this behaviour has been removed, and presumably tests will work once 0.4.0 is released.
  # def self.check
  #   system 'make', 'test'
  # end

  # TODO: 0.3.9 has a weird way of handling PREFIX, swap to normal ('make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install') when 0.4.0 releases.
  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/chruby", <<~CHRUBYEOF
      # chruby configuration
      source #{CREW_PREFIX}/share/chruby/chruby.sh
    CHRUBYEOF
  end
end
