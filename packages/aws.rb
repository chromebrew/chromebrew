require 'package'

class Aws < Package
  description 'The AWS CLI is an open source tool built on top of the AWS SDK for Python (Boto) that provides commands for interacting with AWS services.'
  homepage 'https://aws.amazon.com/documentation/cli/'
  version '1.11.121'
  source_url 'https://github.com/aws/aws-cli/archive/1.11.121.tar.gz'
  source_sha256 'c667e77880a093d5ef3d635f19e7eab3cb0b7527f648d74e571fca8d170474a8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.11.121-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.11.121-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.11.121-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.11.121-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1624bdbf0a968b17d45a85d4415c2240e15fc6c6e2afb8a406787a7e30a92b42',
     armv7l: '1624bdbf0a968b17d45a85d4415c2240e15fc6c6e2afb8a406787a7e30a92b42',
       i686: 'b9842c00b418b90f83102d7096495c3c7eca3d52b5f5ed88506ad53717bade23',
     x86_64: '3fb6256209843cc0dcfaf81089516787427f77697e9b561b920eedf8aee864a3',
  })

  depends_on 'python27' unless File.exists? '/usr/local/bin/python'
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
