require 'package'

class Aws < Package
  description 'The AWS CLI is an open source tool built on top of the AWS SDK for Python (Boto) that provides commands for interacting with AWS services.'
  homepage 'https://aws.amazon.com/documentation/cli/'
  version '1.14.32'
  source_url 'https://github.com/aws/aws-cli/archive/1.14.32.tar.gz'
  source_sha256 'de84cef870b78198168404af27c7ab511dc27b0c28e1be6e4ed77fd8dbd4b78c'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/python"
  depends_on 'unzip'

  def self.install
    system "wget https://s3.amazonaws.com/aws-cli/awscli-bundle.zip"
    system "unzip awscli-bundle.zip"
    system "awscli-bundle/install -i #{CREW_PREFIX}/share/aws -b #{CREW_PREFIX}/bin/aws"
    system "chmod +x #{CREW_PREFIX}/bin/aws"
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/share"
    system "cp #{CREW_PREFIX}/bin/aws #{CREW_DEST_PREFIX}/bin"
    system "cp -r #{CREW_PREFIX}/share/aws #{CREW_DEST_PREFIX}/share"
  end
end
