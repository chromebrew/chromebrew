require 'package'

class Aws < Package
  description 'The AWS CLI is an open source tool built on top of the AWS SDK for Python (Boto) that provides commands for interacting with AWS services.'
  homepage 'https://aws.amazon.com/documentation/cli/'
  version '1.15.6'
  source_url 'https://github.com/aws/aws-cli/archive/1.15.6.tar.gz'
  source_sha256 '8dbc72ba35802579c99a18a0821932c15cd44e3456aaab986f3e68824e4722b6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.15.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.15.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.15.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.15.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4b94294abde4f05a2be26b748036400c456322c303ba274c5f3dcc08be879a05',
     armv7l: '4b94294abde4f05a2be26b748036400c456322c303ba274c5f3dcc08be879a05',
       i686: '78c0ad96c3d70e0d0124fd458a78a4221477fe659dd3966d3ab14cbd4b9f7fd2',
     x86_64: 'f8a8b52a993aefe3f601badaba08a676ca53486e83484feda732bc3916636c1b',
  })

  depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/python"
  depends_on 'unzip' => :build

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
