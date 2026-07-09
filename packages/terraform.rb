require 'package'

class Terraform < Package
  description 'Terraform is a tool for building, changing, and combining infrastructure safely and efficiently.'
  homepage 'https://www.terraform.io/'
  version '1.15.8'
  license 'Apache-2.0, BSD-2, BSD-4, ECL-2.0, imagemagick, ISC, JSON, MIT, MIT-with-advertising, MPL-2.0 and unicode'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_arm.zip",
     armv7l: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_arm.zip",
       i686: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_386.zip",
     x86_64: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: '9e6964abf11a84db1fa84d67adbfb9caf52ef5d03fdc1beb122c66129b9337d4',
     armv7l: '9e6964abf11a84db1fa84d67adbfb9caf52ef5d03fdc1beb122c66129b9337d4',
       i686: '9950419b5a5815c92359d55a62103a7444b3c7dad1299e0a3f96b540dc2dba0f',
     x86_64: 'd25ce7b6902013ad905db3d2eab0be4cd905887fe88b81a6171b8d5503c31f3d'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'terraform', "#{CREW_DEST_PREFIX}/bin/terraform", mode: 0o755
  end

  def self.postinstall
    puts "\nType 'terraform' to get started.\n".lightblue
  end
end
