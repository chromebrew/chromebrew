require 'package'

class Stack < Package
  description 'The Haskell Tool Stack - Stack is a cross-platform program for developing Haskell projects. It is aimed at Haskellers both new and experienced.'
  homepage 'https://docs.haskellstack.org/en/stable/README/'
  @_ver = '2.5.1'
  version @_ver
  compatibility 'x86_64'
  source_url "https://github.com/commercialhaskell/stack/releases/download/v#{@_ver}/stack-#{@_ver}-linux-x86_64.tar.gz"
  source_sha256 `curl -Ls https://github.com/commercialhaskell/stack/releases/download/v#{@_ver}/stack-#{@_ver}-linux-x86_64.tar.gz.sha256 |\
                 tail -n1 | cut -d ' ' -f1`.tr("\n", '') if (ARGV[0] == 'install' or ARGV[0] == 'reinstall')

  def self.install
    FileUtils.mkdir_p CREW_DEST_HOME
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/.stack"
    FileUtils.ln_s "#{CREW_PREFIX}/.stack", "#{CREW_DEST_HOME}/.stack"
    FileUtils.install 'stack', "#{CREW_DEST_PREFIX}/bin/stack", mode: 0755
    
    @config = <<~EOF
      local-bin-path: #{CREW_PREFIX}/bin
      local-programs-path: #{CREW_PREFIX}/share/stack
    EOF
       
    File.write("#{CREW_DEST_PREFIX}/.stack/config.yaml", @config)
  end

  def self.postinstall
    puts
    puts "To enable stack auto-completion, execute the following:".lightblue
    puts "echo '# enable stack auto-completion' >> ~/.bashrc".lightblue
    puts "echo 'eval \"\$(stack --bash-completion-script stack)\"' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
  end
  
  def self.remove
    FileUtils.rm_rf "#{CREW_PREFIX}/share/stack"
    FileUtils.rm_rf "#{HOME}/.stack"
  end
end
