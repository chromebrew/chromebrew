require 'buildsystems/autotools'

class Cowsay < Autotools
  description 'cowsay is a program that generates ASCII pictures of a cow with a message.'
  homepage 'https://github.com/cowsay-org/cowsay'
  version '3.8.4'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/cowsay-org/cowsay.git'
  git_hashtag "v#{version}"

  no_compile_needed

  def self.build
    File.write '10-cowsay', <<~COWSAYEOF
      # Set COWPATH for cowsay
      export COWPATH=#{CREW_PREFIX}/share/cows
    COWSAYEOF
  end

  autotools_install_extras do
    FileUtils.install '10-cowsay', "#{CREW_DEST_PREFIX}/etc/env.d/10-cowsay", mode: 0o644
  end
end
