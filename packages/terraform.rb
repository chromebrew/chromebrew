require 'package'

class Terraform < Package
  description 'Terraform is a tool for building, changing, and combining infrastructure safely and efficiently.'
  homepage 'https://www.terraform.io/'
  version '1.14.0'
  license 'Apache-2.0, BSD-2, BSD-4, ECL-2.0, imagemagick, ISC, JSON, MIT, MIT-with-advertising, MPL-2.0 and unicode'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_arm.zip",
     armv7l: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_arm.zip",
       i686: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_386.zip",
     x86_64: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: '6388284e9a6bb37b7a386131c6dde9b975eea172170f064e2cc42dffcc572d16',
     armv7l: '6388284e9a6bb37b7a386131c6dde9b975eea172170f064e2cc42dffcc572d16',
       i686: '13fee8b3da3f128e4d2b0cc0ca4f2a90853f6275a86fa9c9342966eef68590dd',
     x86_64: '33ac217458ba8b44ce2813553083bc132c9a07e41a79c2e3627977682d283093'
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'terraform', "#{CREW_DEST_PREFIX}/bin/terraform", mode: 0o755
  end

  def self.postinstall
    puts "\nType 'terraform' to get started.\n".lightblue
  end
end
