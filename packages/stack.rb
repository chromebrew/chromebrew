require 'package'

class Stack < Package
  description 'The Haskell Tool Stack - Stack is a cross-platform program for developing Haskell projects. It is aimed at Haskellers both new and experienced.'
  homepage 'https://docs.haskellstack.org/en/stable/README/'
  version '1.6.3'

  case ARCH
  when 'i686'
    source_url 'https://github.com/commercialhaskell/stack/releases/download/v1.6.3/stack-1.6.3-linux-i386.tar.gz'
    source_sha256 '31696f91a26db6a49dff438aff6bda071ad186356c8af1abfbe093b6a04ea3e8'
  when 'x86_64'
    source_url 'https://github.com/commercialhaskell/stack/releases/download/v1.6.3/stack-1.6.3-linux-x86_64.tar.gz'
    source_sha256 '98cab9117a1b3d98207f67fe7abc6381a80dbeaa12780a8577dd1e03add0aab3'
  else
    puts "#{ARCH} architecture not supported.".lightred
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "mkdir $HOME/.stack"
    system "mkdir -p #{CREW_DEST_DIR}$HOME/.stack"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/stack"
    system "install -Dm755 stack #{CREW_DEST_PREFIX}/bin/stack"
    system "echo 'local-bin-path: #{CREW_PREFIX}/bin' > $HOME/.stack/config.yaml"
    system "echo 'local-programs-path: #{CREW_PREFIX}/share/stack' >> $HOME/.stack/config.yaml"
    system "cp $HOME/.stack/config.yaml #{CREW_DEST_DIR}$HOME/.stack"
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
