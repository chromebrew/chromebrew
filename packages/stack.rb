require 'package'

class Stack < Package
  description 'The Haskell Tool Stack - Stack is a cross-platform program for developing Haskell projects. It is aimed at Haskellers both new and experienced.'
  homepage 'https://docs.haskellstack.org/en/stable/README/'
  version '1.9.0.1'

  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/commercialhaskell/stack/releases/download/v1.9.0.1/stack-1.9.0.1-linux-arm.tar.gz'
    source_sha256 'd5401e11e5419ff8f30a88dcec8864c66067b01f36b3e32e279b48335b0ffd70'
  when 'i686'
    source_url 'https://github.com/commercialhaskell/stack/releases/download/v1.9.0.1/stack-1.9.0.1-linux-i386.tar.gz'
    source_sha256 '8e7802340d8c820a89bb0c670b635e2286f48fb8175f89e7205fee92408715bb'
  when 'x86_64'
    source_url 'https://github.com/commercialhaskell/stack/releases/download/v1.9.0.1/stack-1.9.0.1-linux-x86_64.tar.gz'
    source_sha256 '92e7b2c8cf607c8554cefb168fbb31f45eb8b08f8021d33af9bc11971abed0d3'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    FileUtils.mkdir "#{ENV['HOME']}/.stack"
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.stack"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/stack"
    system "install -Dm755 stack #{CREW_DEST_PREFIX}/bin/stack"
    system "echo 'local-bin-path: #{CREW_PREFIX}/bin' > #{ENV['HOME']}/.stack/config.yaml"
    system "echo 'local-programs-path: #{CREW_PREFIX}/share/stack' >> #{ENV['HOME']}/.stack/config.yaml"
    system "cp #{ENV['HOME']}/.stack/config.yaml #{CREW_DEST_HOME}/.stack"
  end

  def self.postinstall
    puts
    puts "To enable stack auto-completion, execute the following:".lightblue
    puts "echo '# enable stack auto-completion' >> ~/.bashrc".lightblue
    puts "echo 'eval \"\$(stack --bash-completion-script stack)\"' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
    puts "To completely uninstall stack, execute the following:".lightblue
    puts "crew remove cabal ghc stack".lightblue
    puts "rm -rf #{CREW_PREFIX}/share/stack".lightblue
    puts "rm -rf ~/.stack".lightblue
    puts
  end
end
