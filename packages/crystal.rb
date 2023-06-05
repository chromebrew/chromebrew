require 'package'

class Crystal < Package
  description 'A language for humans and computers'
  homepage 'https://crystal-lang.org/'
  version '1.6.0'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url 'https://github.com/crystal-lang/crystal/releases/download/1.6.0/crystal-1.6.0-1-linux-x86_64-bundled.tar.gz'
  source_sha256 '5b1b287563839c3c9a2fa7b620c48b5c56de0756464e8370f3a7f720a3ba4df0'

  depends_on 'llvm_lib16' # R

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX.to_s
    FileUtils.mv %w[bin lib share], CREW_DEST_PREFIX.to_s
    bashcomp = <<~EOF
      # Crystal bash completion
      source "#{CREW_PREFIX}/share/bash-completion/completions/crystal"
    EOF
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d"
    File.write("#{CREW_DEST_PREFIX}/etc/bash.d/10-crystal", bashcomp)
  end

  def self.postinstall
    puts "\nTo finish the installation, execute the following:".lightblue
    puts "source ~/.bashrc\n".lightblue
  end
end
