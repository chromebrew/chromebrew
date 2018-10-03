require 'package'

class Aws < Package
  description 'The AWS CLI is an open source tool built on top of the AWS SDK for Python (Boto) that provides commands for interacting with AWS services.'
  homepage 'https://aws.amazon.com/documentation/cli/'
  version '1.16.25'
  source_url 'https://github.com/aws/aws-cli/archive/1.16.25.tar.gz'
  source_sha256 '7c785969c320d8f00c5f4b6daee9e7f1377ec0de045ff811a645b709f534fd82'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.16.25-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.16.25-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.16.25-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.16.25-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '73277b0e0432e94a3333a4a30910d61c8981f6855ec5b5332ad615b8612d1f72',
     armv7l: '73277b0e0432e94a3333a4a30910d61c8981f6855ec5b5332ad615b8612d1f72',
       i686: '539e4ca588ed1e08e40fc43545c3571f0918ca1535edd51d003a78f414705463',
     x86_64: 'a4b818f502f67f96ff727736304cef7db926384ee3baf4405890033480d6c110',
  })

  depends_on 'python3'

  def self.build
    system "sed -i 's,-e git://github.com/boto/botocore.git@develop#egg=botocore,botocore==1.12.15,' requirements.txt"
    system "sed -i 's,-e git://github.com/boto/s3transfer.git@develop#egg=s3transfer,s3transfer==0.1.13,' requirements.txt"
    system "sed -i 's,-e git://github.com/boto/jmespath.git@develop#egg=jmespath,jmespath==0.9.3,' requirements.txt"
  end

  def self.install
    system "pip3 install awscli==1.16.25 -r requirements.txt --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
    system "chmod +x #{CREW_DEST_PREFIX}/bin/aws"
    system "chmod +x #{CREW_DEST_PREFIX}/bin/aws_completer"
  end

  def self.postinstall
    puts
    puts "Command completion support is available for the following shells:".lightblue
    puts "bash zsh".lightblue
    puts
    puts "To add aws completion for bash, execute the following:".lightblue
    puts "echo '# aws completion' >> ~/.bashrc".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/bin/aws_bash_completer ]; then' >> ~/.bashrc".lightblue
    puts "echo '  source #{CREW_PREFIX}/bin/aws_bash_completer' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
    puts "To add aws completion for zsh, execute the following:".lightblue
    puts "echo '# aws completion' >> ~/.zshrc".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/bin/aws_zsh_completer.sh ]; then' >> ~/.zshrc".lightblue
    puts "echo '  source #{CREW_PREFIX}/bin/aws_zsh_completer.sh' >> ~/.zshrc".lightblue
    puts "echo 'fi' >> ~/.zshrc".lightblue
    puts "source ~/.zshrc".lightblue
    puts
  end
end
