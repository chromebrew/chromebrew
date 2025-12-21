require 'package'

class Stack < Package
  description 'The Haskell Tool Stack - Stack is a cross-platform program for developing Haskell projects. It is aimed at Haskellers both new and experienced.'
  homepage 'https://docs.haskellstack.org/'
  version '3.7.1'
  license 'BSD'
  compatibility 'x86_64'
  source_url "https://github.com/commercialhaskell/stack/releases/download/v#{version}/stack-#{version}-linux-x86_64-bin"
  source_sha256 'c9ba670e7efd3f3807528e60ad09667dd37eba3d941c7edf6ab09d938abc70a8'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install "stack-#{version}-linux-#{ARCH}-bin", "#{CREW_DEST_PREFIX}/bin/stack", mode: 0o755

    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.stack"
    File.write "#{CREW_DEST_HOME}/.stack/config.yaml", <<~EOF
      local-bin-path: #{CREW_PREFIX}/bin
      local-programs-path: #{CREW_PREFIX}/share/stack
    EOF

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    File.write "#{CREW_DEST_PREFIX}/etc/bash.d/10-stack", <<~EOF
      # Haskell stack bash completion
      eval "$(stack --bash-completion-script stack)"
    EOF
  end

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/share/stack")
  end
end
