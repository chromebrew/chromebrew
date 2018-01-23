require 'package'

class Aws < Package
  description 'The AWS CLI is an open source tool built on top of the AWS SDK for Python (Boto) that provides commands for interacting with AWS services.'
  homepage 'https://aws.amazon.com/documentation/cli/'
  version '1.14.16'
  source_url 'https://github.com/aws/aws-cli/archive/1.14.16.tar.gz'
  source_sha256 '5134f47dc0f6a45c0600e71abf040965f5356f5185e544f78f8b975f7d2d3e21'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.14.16-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.14.16-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.14.16-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aws-1.14.16-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'aeff85395a5937d5796fbe91c94c49421d73e4e76cb0913c9552c0455435661d',
     armv7l: 'aeff85395a5937d5796fbe91c94c49421d73e4e76cb0913c9552c0455435661d',
       i686: '95897d6c609d9f775d1bda59075dbab02e98f1a1fa6209c28d11059df80026c2',
     x86_64: 'c85943d67869c652453668588b5c52992a6c1a6124285cdcfbeddd3404463f4a',
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
