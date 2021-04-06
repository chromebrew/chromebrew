require 'package'

class Awscli < Package
  description 'The AWS CLI is an open source tool built on top of the AWS SDK for Python (Boto) that provides commands for interacting with AWS services.'
  homepage 'https://aws.amazon.com/documentation/cli/'
  version '1.19.45'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aws/aws-cli/archive/1.19.45.tar.gz'
  source_sha256 '67b2c0066a17a9592767c57e038db93f98d289694c8fc5a27e27b85ffbfa674c'

  depends_on 'py3_botocore'
  depends_on 'py3_colorama'
  depends_on 'py3_docutils'
  depends_on 'py3_pyyaml'
  depends_on 'py3_s3transfer'
  depends_on 'py3_rsa'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
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
