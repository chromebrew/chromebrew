require 'package'

class Cf < Package
  description 'The official command line client for Cloud Foundry'
  homepage 'https://docs.cloudfoundry.org/cf-cli'
  version '6.36.1'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686', 'x86_64'
    source_url 'https://raw.githubusercontent.com/cloudfoundry/cli/v6.36.1/README.md'
    source_sha256 'e760fc21cdee6960dbd864e48c08630eabe33af0bb1bb4d412a22d4bb9ac6a06'
  end

  binary_url ({
      i686: 'https://dl.bintray.com/chromebrew/chromebrew/cf-6.36.1-chromeos-i686.tar.xz',
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cf-6.36.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
      i686: '8fc3e0c54791538211b3b5d2c7b4756da9c122637917baeceb025dda4be5347d',
    x86_64: 'd99c348433cef60967da0322bbf3035e28959a24d50c5042c489cf3b14d35feb',
  })

  def self.install
    case ARCH
    when 'i686'
      system 'wget https://s3-us-west-1.amazonaws.com/cf-cli-releases/releases/v6.36.1/cf-cli_6.36.1_linux_i686.tgz'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('cf-cli_6.36.1_linux_i686.tgz') ) == '9e6383521345370e9a266d11ff4f827e853d2dfbf999bcb9e6a0f62ec69c3b0f'
      system 'tar xvf cf-cli_6.36.1_linux_i686.tgz'
      system "install -Dm755 cf #{CREW_DEST_PREFIX}/bin/cf"
      system "curl -o cf.bash https://raw.githubusercontent.com/cloudfoundry/cli/v6.36.1/ci/installers/completion/cf"
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('cf.bash') ) == 'f3f05a2414075c00b101b05f73cf260b9eec9966659adf2957c1b2937bd4c48e'
      system "install -Dm644 cf.bash #{CREW_DEST_PREFIX}/share/cf/bash-completion/cf.bash"
    when 'x86_64'
      system 'wget https://s3-us-west-1.amazonaws.com/cf-cli-releases/releases/v6.36.1/cf-cli_6.36.1_linux_x86-64.tgz'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('cf-cli_6.36.1_linux_x86-64.tgz') ) == 'd5e59258183939305f44c471dab41a000290446399cc9b206b107c7bdb8ce180'
      system 'tar xvf cf-cli_6.36.1_linux_x86-64.tgz'
      system "install -Dm755 cf #{CREW_DEST_PREFIX}/bin/cf"
      system "curl -L -o cf.bash https://raw.githubusercontent.com/cloudfoundry/cli/v6.36.1/ci/installers/completion/cf"
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('cf.bash') ) == 'f3f05a2414075c00b101b05f73cf260b9eec9966659adf2957c1b2937bd4c48e'
      system "install -Dm644 cf.bash #{CREW_DEST_PREFIX}/share/cf/bash-completion/cf.bash"
    end
  end

  def self.postinstall
    case ARCH
    when 'i686', 'x86_64'
      puts
      puts "To add bash completion, execute the following:".lightblue
      puts "echo 'if [ -f #{CREW_PREFIX}/share/cf/bash-completion/cf.bash ]; then' >> ~/.bashrc".lightblue
      puts "echo '  source #{CREW_PREFIX}/share/cf/bash-completion/cf.bash' >> ~/.bashrc".lightblue
      puts "echo 'fi' >> ~/.bashrc".lightblue
      puts "source ~/.bashrc".lightblue
      puts
    end
  end
end
