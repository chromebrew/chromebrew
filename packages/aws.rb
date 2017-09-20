require 'package'

class Aws < Package
  description 'The AWS CLI is an open source tool built on top of the AWS SDK for Python (Boto) that provides commands for interacting with AWS services.'
  homepage 'https://aws.amazon.com/documentation/cli/'
  version '1.11.156'
  source_url 'https://github.com/aws/aws-cli/archive/1.11.156.tar.gz'
  source_sha256 'e16e4e7e56b94bcbd97e1ef2131f8b760ab0e06ac80b73caae1304c9b6d2a1e2'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/python"
  depends_on 'unzip'

  def self.install
    system "wget https://s3.amazonaws.com/aws-cli/awscli-bundle.zip"
    system "unzip awscli-bundle.zip"
    system "awscli-bundle/install -i #{CREW_PREFIX}/aws -b #{CREW_PREFIX}/bin/aws"
    system "chmod +x #{CREW_PREFIX}/bin/aws"
    system "mkdir -p #{CREW_DEST_PREFIX}/aws"
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "cp -r #{CREW_PREFIX}/aws #{CREW_DEST_PREFIX}"
    system "cp #{CREW_PREFIX}/bin/aws #{CREW_DEST_PREFIX}/bin"
  end
end
