require 'package'

class Terraform < Package
  description 'Terraform is a tool for building, changing, and combining infrastructure safely and efficiently.'
  homepage 'https://www.terraform.io/'
  version '1.16.0'
  license 'Apache-2.0, BSD-2, BSD-4, ECL-2.0, imagemagick, ISC, JSON, MIT, MIT-with-advertising, MPL-2.0 and unicode'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_arm.zip",
     armv7l: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_arm.zip",
       i686: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_386.zip",
     x86_64: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: 'ae6f7a891fa7d65b30d7c1cebcd02b2ea2998632ec3def200b4fb9d3d3f135c9',
     armv7l: 'ae6f7a891fa7d65b30d7c1cebcd02b2ea2998632ec3def200b4fb9d3d3f135c9',
       i686: '1a61829dea3bb5194433f8a44619cd696817706fb4e2d67caaa56aa0bdc6bde3',
     x86_64: '41d05b927aa174f15d1228c4eba832a323b716c68b415ef5a00179f46cc602d3'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'terraform', "#{CREW_DEST_PREFIX}/bin/terraform", mode: 0o755
  end

  def self.postinstall
    puts "\nType 'terraform' to get started.\n".lightblue
  end
end
