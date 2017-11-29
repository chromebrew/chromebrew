require 'package'

class Aws < Package
  description 'The AWS CLI is an open source tool built on top of the AWS SDK for Python (Boto) that provides commands for interacting with AWS services.'
  homepage 'https://aws.amazon.com/documentation/cli/'
  version '1.11.156'
  source_url 'https://github.com/aws/aws-cli/archive/1.11.156.tar.gz'
  source_sha256 'e16e4e7e56b94bcbd97e1ef2131f8b760ab0e06ac80b73caae1304c9b6d2a1e2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.11.156-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.11.156-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.11.156-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.11.156-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '94283e523ede3bab13212838f74f346a3894c7f4d5674771107e137be7d6f451',
     armv7l: '94283e523ede3bab13212838f74f346a3894c7f4d5674771107e137be7d6f451',
       i686: '0bb6ba9e25f13e17b854978ecd13e1a817dccf83454a961f546d2522e1b6fce0',
     x86_64: '8412d555077d4fde32577f63e0df68b95c742df031a75f13b7c26004dd997761',
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
