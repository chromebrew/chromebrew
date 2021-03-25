require 'package'

class Aws < Package
  description 'The AWS CLI is an open source tool built on top of the AWS SDK for Python (Boto) that provides commands for interacting with AWS services.'
  homepage 'https://aws.amazon.com/documentation/cli/'
  version '1.17.13-1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aws/aws-cli/archive/1.17.13.tar.gz'
  source_sha256 '4dc8ff38ca67341021f6e2971084d7ed8b87968443e089e758b5531f1381205f'

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
    
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d"
    @awsbashrc = <<~EOF
      # Amazon Web Services CLI bash completion
      source #{CREW_PREFIX}/bin/aws_bash_completer
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/aws", @awsbashrc)
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/zsh.d"
    @awszshrc = <<~EOF
      # Amazon Web Services CLI zsh completion
      source #{CREW_PREFIX}/bin/aws_zsh_completer.sh
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/aws", @awszshrc)
  end
end
