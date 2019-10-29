require 'package'

class Stack < Package
  description 'The Haskell Tool Stack - Stack is a cross-platform program for developing Haskell projects. It is aimed at Haskellers both new and experienced.'
  homepage 'https://docs.haskellstack.org/en/stable/README/'
  version '2.1.3'

  case ARCH
  when 'aarch64'
    source_url 'https://github.com/commercialhaskell/stack/releases/download/v2.1.3/stack-2.1.3-linux-aarch64.tar.gz'
    source_sha256 '96394b616e29b3bd2479a3712e2c0c375a7cfd748b613f7c6c3186d7ae92977b'
  when 'armv7l'
    source_url 'https://github.com/commercialhaskell/stack/releases/download/v2.1.3/stack-2.1.3-linux-arm.tar.gz'
    source_sha256 '6c8a2100183368d0fe8298bc99260681f10c81838423884be885baaa2e096e78'
  when 'i686'
    source_url 'https://github.com/commercialhaskell/stack/releases/download/v2.1.3/stack-2.1.3-linux-i386.tar.gz'
    source_sha256 '4acd97f4c91b1d1333c8d84ea38f690f0b5ac5224ba591f8cdd1b9d0e8973807'
  when 'x86_64'
    source_url 'https://github.com/commercialhaskell/stack/releases/download/v2.1.3/stack-2.1.3-linux-x86_64.tar.gz'
    source_sha256 'c724b207831fe5f06b087bac7e01d33e61a1c9cad6be0468f9c117d383ec5673'
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
