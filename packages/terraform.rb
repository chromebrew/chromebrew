require 'package'

class Terraform < Package
  description 'Terraform is a tool for building, changing, and combining infrastructure safely and efficiently.'
  homepage 'https://www.terraform.io/'
  version '1.8.5'
  license 'Apache-2.0, BSD-2, BSD-4, ECL-2.0, imagemagick, ISC, JSON, MIT, MIT-with-advertising, MPL-2.0 and unicode'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_arm.zip",
     armv7l: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_arm.zip",
       i686: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_386.zip",
     x86_64: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: '180701072b7f9f8bdb6854348fb0e728a78c778595cdf33b5462a7c9fa93689f',
     armv7l: '180701072b7f9f8bdb6854348fb0e728a78c778595cdf33b5462a7c9fa93689f',
       i686: '6dbfc8c6b0c250d17faac79d55823f2e6079d21ace62939193c693d012a3f88e',
     x86_64: '026da7f222d6c7506e882173cb48611d50638dcbe98e87639e047797bee69817'
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'terraform', "#{CREW_DEST_PREFIX}/bin/terraform", mode: 0o755
  end

  def self.postinstall
    puts "\nType 'terraform' to get started.\n".lightblue
  end
end
