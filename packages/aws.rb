require 'package'

class Aws < Package
  description 'The AWS CLI is an open source tool built on top of the AWS SDK for Python (Boto) that provides commands for interacting with AWS services.'
  homepage 'https://aws.amazon.com/documentation/cli/'
  version '1.11.110'
  source_url 'https://github.com/aws/aws-cli/archive/1.11.110.tar.gz'
  source_sha1 'a30e4f23951c06bb4ab9ffaa9ac42188fae6d6ba'

  depends_on 'python' unless File.exists? '/usr/local/bin/python'
  depends_on 'unzip'

  def self.install
    system "wget https://s3.amazonaws.com/aws-cli/awscli-bundle.zip"
    system "unzip awscli-bundle.zip"
    system "awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws"
    system "chmod +x /usr/local/bin/aws"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/aws"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp -r /usr/local/aws #{CREW_DEST_DIR}/usr/local"
    system "cp /usr/local/bin/aws #{CREW_DEST_DIR}/usr/local/bin"
  end
end
