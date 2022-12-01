require 'package'

class Terraform < Package
  description 'Terraform is a tool for building, changing, and combining infrastructure safely and efficiently.'
  homepage 'https://www.terraform.io/'
  version '1.3.6'
  license 'Apache-2.0, BSD-2, BSD-4, ECL-2.0, imagemagick, ISC, JSON, MIT, MIT-with-advertising, MPL-2.0 and unicode'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_arm.zip",
     armv7l: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_arm.zip",
       i686: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_386.zip",
     x86_64: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: 'f4b1af29094290f1b3935c29033c4e5291664ee2c015ca251a020dd425c847c3',
     armv7l: 'f4b1af29094290f1b3935c29033c4e5291664ee2c015ca251a020dd425c847c3',
       i686: 'f19ff7715cffa5064c39d07d83d2dfdb0a15fd3ae4ffb35beabca95ed8b9a185',
     x86_64: 'bb44a4c2b0a832d49253b9034d8ccbd34f9feeb26eda71c665f6e7fa0861f49b'
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'terraform', "#{CREW_DEST_PREFIX}/bin/terraform", mode: 0o755
  end

  def self.postinstall
    puts "\nType 'terraform' to get started.\n".lightblue
  end
end
