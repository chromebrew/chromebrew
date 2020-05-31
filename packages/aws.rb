require 'package'

class Aws < Package
  description 'The AWS CLI is an open source tool built on top of the AWS SDK for Python (Boto) that provides commands for interacting with AWS services.'
  homepage 'https://aws.amazon.com/documentation/cli/'
  version '1.17.13'
  source_url 'https://github.com/aws/aws-cli/archive/1.17.13.tar.gz'
  source_sha256 '4dc8ff38ca67341021f6e2971084d7ed8b87968443e089e758b5531f1381205f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.17.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.17.13-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.17.13-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.17.13-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8f291de2ee2c9766dedb1b60ef178fdf4fa7554e3a305c6035decbce2661fb91',
     armv7l: '8f291de2ee2c9766dedb1b60ef178fdf4fa7554e3a305c6035decbce2661fb91',
       i686: 'ba5feb2b679177d47da9c08b482990be1259559bfa0cc005acfcaf429412a0f0',
     x86_64: '1a52ec06dd1e471b64e14f27a14a783ca7488bb6016b245b20ef29d4cbceb833',
  })

  depends_on 'setuptools' => :build
  depends_on 'six'

  def self.build
    system "sed -i 's,-e git://github.com/boto/botocore.git@develop#egg=botocore,botocore==1.14.13,' requirements.txt"
    system "sed -i 's,-e git://github.com/boto/s3transfer.git@develop#egg=s3transfer,s3transfer==0.3.3,' requirements.txt"
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
