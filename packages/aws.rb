require 'package'

class Aws < Package
  description 'The AWS CLI is an open source tool built on top of the AWS SDK for Python (Boto) that provides commands for interacting with AWS services.'
  homepage 'https://aws.amazon.com/documentation/cli/'
  version '1.16.115'
  source_url 'https://github.com/aws/aws-cli/archive/1.16.115.tar.gz'
  source_sha256 '7ef52afac9f424a8693fdecad9ec2e4d752c2cb471cd7cbf3dcdc98ea017e08a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.16.115-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.16.115-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.16.115-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.16.115-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '00f028140dd82e1c42d8897996c05a735df1fc7f345bb6dbd361979e7c1acca3',
     armv7l: '00f028140dd82e1c42d8897996c05a735df1fc7f345bb6dbd361979e7c1acca3',
       i686: '4e7964fcca3a9b0911dd3f08b6257e3c6a7d1869fb8d4ae091cfa1c16048413e',
     x86_64: 'e12e295100e9f71db4e8e77f75de976f1d7964bb35bae27953216b2e4aab8b95',
  })

  depends_on 'six'

  def self.build
    system "sed -i 's,-e git://github.com/boto/botocore.git@develop#egg=botocore,botocore==1.12.105,' requirements.txt"
    system "sed -i 's,-e git://github.com/boto/s3transfer.git@develop#egg=s3transfer,s3transfer==0.2.0,' requirements.txt"
    system "sed -i 's,-e git://github.com/boto/jmespath.git@develop#egg=jmespath,jmespath==0.9.4,' requirements.txt"
  end

  def self.install
    system "pip install awscli==#{version} -r requirements.txt --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
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
