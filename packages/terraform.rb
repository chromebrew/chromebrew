require 'package'

class Terraform < Package
  description 'Terraform is a tool for building, changing, and combining infrastructure safely and efficiently.'
  homepage 'https://www.terraform.io/'
  version '1.15.2'
  license 'Apache-2.0, BSD-2, BSD-4, ECL-2.0, imagemagick, ISC, JSON, MIT, MIT-with-advertising, MPL-2.0 and unicode'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_arm.zip",
     armv7l: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_arm.zip",
       i686: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_386.zip",
     x86_64: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: '6e0f8ab581563adb707587ae5ae58ca1ee210c7f719795671d6f922bcb76d708',
     armv7l: '6e0f8ab581563adb707587ae5ae58ca1ee210c7f719795671d6f922bcb76d708',
       i686: 'aa754edbb9cf035cf15f820514123cb7c452875c27005f1beea1ed3665f40962',
     x86_64: 'c56ff2bc7e6ce9b3879a50392b03c2ea074b47688bf503ff966c87fb01b2aab8'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'terraform', "#{CREW_DEST_PREFIX}/bin/terraform", mode: 0o755
  end

  def self.postinstall
    puts "\nType 'terraform' to get started.\n".lightblue
  end
end
