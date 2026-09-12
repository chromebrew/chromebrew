require 'package'

class Terraform < Package
  description 'Terraform is a tool for building, changing, and combining infrastructure safely and efficiently.'
  homepage 'https://www.terraform.io/'
  version '1.16.2'
  license 'Apache-2.0, BSD-2, BSD-4, ECL-2.0, imagemagick, ISC, JSON, MIT, MIT-with-advertising, MPL-2.0 and unicode'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_arm.zip",
     armv7l: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_arm.zip",
       i686: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_386.zip",
     x86_64: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: '456d3fc4b2d3b04509cdc0bd1f00fe4535d2c4c8c74e7da729864bc75b67335b',
     armv7l: '456d3fc4b2d3b04509cdc0bd1f00fe4535d2c4c8c74e7da729864bc75b67335b',
       i686: '40b90f2f6d73e8622a73e5fa76989da2afcb83a2ab872ad2472844c13fd86506',
     x86_64: '0d17011f0c4664539b164b044903d04e296c86c13cb9f28040076c65cfb3985a'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'terraform', "#{CREW_DEST_PREFIX}/bin/terraform", mode: 0o755
  end

  def self.postinstall
    puts "\nType 'terraform' to get started.\n".lightblue
  end
end
