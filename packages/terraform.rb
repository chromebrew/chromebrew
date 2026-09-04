require 'package'

class Terraform < Package
  description 'Terraform is a tool for building, changing, and combining infrastructure safely and efficiently.'
  homepage 'https://www.terraform.io/'
  version '1.16.1'
  license 'Apache-2.0, BSD-2, BSD-4, ECL-2.0, imagemagick, ISC, JSON, MIT, MIT-with-advertising, MPL-2.0 and unicode'
  compatibility 'all'
  source_url({
    aarch64: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_arm.zip",
     armv7l: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_arm.zip",
       i686: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_386.zip",
     x86_64: "https://releases.hashicorp.com/terraform/#{version}/terraform_#{version}_linux_amd64.zip"
  })
  source_sha256({
    aarch64: 'd60ad6dfa813ea89470ad1ea2f54776e5b4a6c1687161957158c718a60a14020',
     armv7l: 'd60ad6dfa813ea89470ad1ea2f54776e5b4a6c1687161957158c718a60a14020',
       i686: '6c2bca9259f64e8ea1da236f3db7f474266141f2b50dbf75594b84a784547d3d',
     x86_64: '745d33b4b02b7980c62a38ec1beea24ee084ea8caf3f503c200554bd9a0cbe49'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'terraform', "#{CREW_DEST_PREFIX}/bin/terraform", mode: 0o755
  end

  def self.postinstall
    puts "\nType 'terraform' to get started.\n".lightblue
  end
end
