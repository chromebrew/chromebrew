require 'package'

class Aws < Package
  description 'The AWS CLI is an open source tool built on top of the AWS SDK for Python (Boto) that provides commands for interacting with AWS services.'
  homepage 'https://aws.amazon.com/documentation/cli/'
  version '1.16.268'
  source_url 'https://github.com/aws/aws-cli/archive/1.16.268.tar.gz'
  source_sha256 'fde1ad4206fe92b27277ba6a21ff3879a0a390ee29679d2b4c9bfb47a7c7ce78'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.16.268-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.16.268-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.16.268-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.16.268-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1e34d559b3d0025a4ffa8d06d729970b32647b2fd06d7c25fd75afb434718964',
     armv7l: '1e34d559b3d0025a4ffa8d06d729970b32647b2fd06d7c25fd75afb434718964',
       i686: 'be9cc4591ee69024f10408adf76ab953022f2a271205489dab98c3d2067f450f',
     x86_64: '0ec34be425dc06028ab9423d1c0a3914f796e440e76d84e0fe3c436f8bb509d5',
  })

  depends_on 'six'

  def self.build
    system "sed -i 's,-e git://github.com/boto/botocore.git@develop#egg=botocore,botocore==1.13.4,' requirements.txt"
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
