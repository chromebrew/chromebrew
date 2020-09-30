require 'package'

class Terraform < Package
  description 'Terraform is a tool for building, changing, and combining infrastructure safely and efficiently.'
  homepage 'https://www.terraform.io/'
  version '0.13.4'
  compatibility 'all'

  case ARCH
    when 'x86_64'
      source_url "https://releases.hashicorp.com/terraform/#{self.version}/terraform_#{self.version}_linux_amd64.zip"
      source_sha256 'a92df4a151d390144040de5d18351301e597d3fae3679a814ea57554f6aa9b24'
    when 'aarch64', 'armv7l'
      source_url "https://releases.hashicorp.com/terraform/#{self.version}/terraform_#{self.version}_linux_arm.zip"
      source_sha256 '28f90802515d2ef8468eafbe4b0125fe812ab383d7707429adb2c8f9ff8aab7d'
    when 'i686'
      source_url 'https://releases.hashicorp.com/terraform/#{self.version}/terraform_#{self.version}_linux_386.zip'
      source_sha256 '16225f17149505a42751599acd8e12d01690324f680e7fa2099afed581876916'
  end

  def self.install
    system "install -Dm755 terraform #{CREW_DEST_PREFIX}/bin/terraform"
  end
end
