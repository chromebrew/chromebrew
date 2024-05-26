require 'package'

class Terraform < Package
  description 'Terraform is a tool for building, changing, and combining infrastructure safely and efficiently.'
  homepage 'https://www.terraform.io/'
  version '1.8.4'
  license 'Apache-2.0, BSD-2, BSD-4, ECL-2.0, imagemagick, ISC, JSON, MIT, MIT-with-advertising, MPL-2.0 and unicode'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_arm.zip",
     armv7l: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_arm.zip",
       i686: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_386.zip",
     x86_64: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: 'a56beb182bb3bf3a6bdbb7236423ecf066d7cdae1dad3a5ac014a20413fbb1ea',
     armv7l: 'a56beb182bb3bf3a6bdbb7236423ecf066d7cdae1dad3a5ac014a20413fbb1ea',
       i686: 'd3937d6ad47673df4ffed750030c00e096e57178c2c57866559747a4dcedc62f',
     x86_64: '8e401db39b9a3a60758f263fcfe3fb0c3d688b99c1f891360863d7798198b5f7'
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'terraform', "#{CREW_DEST_PREFIX}/bin/terraform", mode: 0o755
  end

  def self.postinstall
    puts "\nType 'terraform' to get started.\n".lightblue
  end
end
