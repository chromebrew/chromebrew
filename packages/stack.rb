require 'package'

class Stack < Package
  description 'The Haskell Tool Stack - Stack is a cross-platform program for developing Haskell projects. It is aimed at Haskellers both new and experienced.'
  homepage 'https://docs.haskellstack.org/'
  version '2.9.3'
  license 'BSD'
  compatibility 'all'
  source_url "https://github.com/commercialhaskell/stack/releases/download/v#{version}/stack-#{version}-linux-x86_64.tar.gz"
  source_sha256 '938f689dc45e2693ab1ca3ea215790b3786dfd531dcf6c0bf40842c24e579ae9'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/stack/2.9.3_armv7l/stack-2.9.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/stack/2.9.3_armv7l/stack-2.9.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/stack/2.9.3_i686/stack-2.9.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/stack/2.9.3_x86_64/stack-2.9.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3551e29cf348081a27f2e598133b9a9a4498a0e0e4b7a098dd0e4b583ccfc7c9',
     armv7l: '3551e29cf348081a27f2e598133b9a9a4498a0e0e4b7a098dd0e4b583ccfc7c9',
       i686: '6df32dce7ba7c5509f93a6b4951a8e1f5cb3e6892f8a402efbe3c46b0d208f15',
     x86_64: 'd6b30d5262a17ed264eec11dc5076cc16ab5810c25dc3c04bb9f3ba6e75cfd33'
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.stack"
    system "install -Dm755 stack #{CREW_DEST_PREFIX}/bin/stack"
    system "echo 'local-bin-path: #{CREW_PREFIX}/bin' > #{CREW_DEST_HOME}/.stack/config.yaml"
    system "echo 'local-programs-path: #{CREW_PREFIX}/share/stack' >> #{CREW_DEST_HOME}/.stack/config.yaml"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @env = <<~EOF
      # Haskell stack bash completion
      eval "$(stack --bash-completion-script stack)"
    EOF
    File.write("#{CREW_DEST_PREFIX}/etc/bash.d/stack", @env)
  end

  def self.remove
    puts
    puts 'To completely uninstall stack, execute the following:'.lightblue
    puts "rm -rf #{CREW_PREFIX}/share/stack".lightblue
    puts 'rm -rf ~/.stack'.lightblue
    puts
  end
end
