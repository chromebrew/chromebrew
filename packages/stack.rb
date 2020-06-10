require 'package'

class Stack < Package
  description 'The Haskell Tool Stack - Stack is a cross-platform program for developing Haskell projects. It is aimed at Haskellers both new and experienced.'
  homepage 'https://docs.haskellstack.org/en/stable/README/'
  version '2.1.3-1'
  compatibility 'all'

  case ARCH
  when 'x86_64'
    source_url 'https://github.com/commercialhaskell/stack/releases/download/v2.1.3/stack-2.1.3-linux-x86_64.tar.gz'
    source_sha256 'c724b207831fe5f06b087bac7e01d33e61a1c9cad6be0468f9c117d383ec5673'
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_HOME
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/.stack"
    system "install -Dm755 stack #{CREW_DEST_PREFIX}/bin/stack"
    system "echo 'local-bin-path: #{CREW_PREFIX}/bin' > #{CREW_DEST_PREFIX}/.stack/config.yaml"
    system "echo 'local-programs-path: #{CREW_PREFIX}/share/stack' >> #{CREW_DEST_PREFIX}/.stack/config.yaml"
    FileUtils.ln_s "#{CREW_PREFIX}/.stack", "#{CREW_DEST_HOME}/.stack"
  end

  def self.postinstall
    puts
    puts "To enable stack auto-completion, execute the following:".lightblue
    puts "echo '# enable stack auto-completion' >> ~/.bashrc".lightblue
    puts "echo 'eval \"\$(stack --bash-completion-script stack)\"' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
    puts "To completely uninstall stack, execute the following:".lightblue
    puts "crew remove stack".lightblue
    puts "rm -rf #{CREW_PREFIX}/share/stack".lightblue
    puts "rm -rf ~/.stack".lightblue
    puts
  end
end
