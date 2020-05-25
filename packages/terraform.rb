require 'package'

class Terraform < Package
  description 'Terraform is a tool for building, changing, and combining infrastructure safely and efficiently.'
  homepage 'https://www.terraform.io/'
  version '0.12.25'

  case ARCH
    when 'x86_64'
      source_url 'https://releases.hashicorp.com/terraform/0.12.25/terraform_0.12.25_linux_amd64.zip'
      source_sha256 'e95daabd1985329f87e6d40ffe7b9b973ff0abc07a403f767e8658d64d733fb0'
    when 'aarch64', 'armv7l'
      source_url 'https://releases.hashicorp.com/terraform/0.12.25/terraform_0.12.25_linux_arm.zip'
      source_sha256 '20979f0f53a0931cd23332cd2c52ed4ec8257797e8050e5b794ad53c791a7e85'
    when 'i686'
      source_url 'https://releases.hashicorp.com/terraform/0.12.25/terraform_0.12.25_linux_386.zip'
      source_sha256 '51a4653dfdbee000bc47f05606ca8f328a1d31ebd6a3b6569230bcd303883571'
  end

  def self.install
    system "install -Dm755 terraform #{CREW_DEST_PREFIX}/bin/terraform"
  end
end
