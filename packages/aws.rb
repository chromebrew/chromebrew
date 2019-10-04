require 'package'

class Aws < Package
  description 'The AWS CLI is an open source tool built on top of the AWS SDK for Python (Boto) that provides commands for interacting with AWS services.'
  homepage 'https://aws.amazon.com/documentation/cli/'
  version '1.16.252'
  source_url 'https://github.com/aws/aws-cli/archive/1.16.252.tar.gz'
  source_sha256 'dfe2021ac11641aa30bf0245f1be9ffcca54af5af6d66a1ed64a96b7bdf43690'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.16.252-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.16.252-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.16.252-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.16.252-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9fcc0324a91701d843c57a0313c2f69a861db5e24edd1a47718c9d25bd36e63a',
     armv7l: '9fcc0324a91701d843c57a0313c2f69a861db5e24edd1a47718c9d25bd36e63a',
       i686: 'b2b31ba38141dac4baef15cb15fd54ac50ad1ccd261b961425b0d6630617c772',
     x86_64: '6bb9bbf1fef058b191ade5a3feb4309afc61288ebbafea79231861f9418b0519',
  })

  depends_on 'six'

  def self.build
    system "sed -i 's,-e git://github.com/boto/botocore.git@develop#egg=botocore,botocore==1.12.242,' requirements.txt"
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
