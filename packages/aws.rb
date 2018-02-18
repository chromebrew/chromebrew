require 'package'

class Aws < Package
  description 'The AWS CLI is an open source tool built on top of the AWS SDK for Python (Boto) that provides commands for interacting with AWS services.'
  homepage 'https://aws.amazon.com/documentation/cli/'
  version '1.14.32'
  source_url 'https://github.com/aws/aws-cli/archive/1.14.32.tar.gz'
  source_sha256 'de84cef870b78198168404af27c7ab511dc27b0c28e1be6e4ed77fd8dbd4b78c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.14.32-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.14.32-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.14.32-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.14.32-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '70d4d81009a0948e2d8069df794c1b52c7864f6918dd78146e30a1ff55c3bb2f',
     armv7l: '70d4d81009a0948e2d8069df794c1b52c7864f6918dd78146e30a1ff55c3bb2f',
       i686: '703001f046ae3ef9e8dfab13e968ae11ece54d737916110dcd7c87ffb25a5fb5',
     x86_64: 'd79bce821399bb5edd1716bbca98b0d9fe83b77e3766859aad820d4b3ef9132d',
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
