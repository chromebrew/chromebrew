require 'package'

class Aws < Package
  description 'The AWS CLI is an open source tool built on top of the AWS SDK for Python (Boto) that provides commands for interacting with AWS services.'
  homepage 'https://aws.amazon.com/documentation/cli/'
  version 'latest'
  source_url 'https://s3.amazonaws.com/aws-cli/awscli-bundle.zip'
  source_sha1 'af083a1e5455a8e040aaeda46e7b634b6510a8af'

  depends_on 'python'
  depends_on 'unzip'

  def self.install
    system "#{CREW_BREW_DIR}/awscli-bundle.zip.dir/awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws"
    system "chmod +x /usr/local/bin/aws"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/aws"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp -r /usr/local/aws #{CREW_DEST_DIR}/usr/local"
    system "cp /usr/local/bin/aws #{CREW_DEST_DIR}/usr/local/bin"
  end
end
