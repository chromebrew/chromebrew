require 'package'

class Stack < Package
  description 'The Haskell Tool Stack - Stack is a cross-platform program for developing Haskell projects. It is aimed at Haskellers both new and experienced.'
  homepage 'https://docs.haskellstack.org/en/stable/README/'
  version '1.9.3'

  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/commercialhaskell/stack/releases/download/v1.9.3/stack-1.9.3-linux-arm.tar.gz'
    source_sha256 '96394b616e29b3bd2479a3712e2c0c375a7cfd748b613f7c6c3186d7ae92977b'
  when 'i686'
    source_url 'https://github.com/commercialhaskell/stack/releases/download/v1.9.3/stack-1.9.3-linux-i386.tar.gz'
    source_sha256 'c7a45fcf782fcc9b2bbac38f9e1b41afec5e940c6e26936a51652f246e226505'
  when 'x86_64'
    source_url 'https://github.com/commercialhaskell/stack/releases/download/v1.9.3/stack-1.9.3-linux-x86_64.tar.gz'
    source_sha256 'e2363728e5818ccc68db9371c15af892a9a1fc86d808d0a9a77257f13696e946'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.stack"
    system "install -Dm755 stack #{CREW_DEST_PREFIX}/bin/stack"
    system "echo 'local-bin-path: #{CREW_PREFIX}/bin' > #{CREW_DEST_HOME}/.stack/config.yaml"
    system "echo 'local-programs-path: #{CREW_PREFIX}/share/stack' >> #{CREW_DEST_HOME}/.stack/config.yaml"
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
