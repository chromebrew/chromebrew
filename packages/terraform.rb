require 'package'

class Terraform < Package
  description 'Terraform is a tool for building, changing, and combining infrastructure safely and efficiently.'
  homepage 'https://www.terraform.io/'
  version '0.11.1'
  source_url 'https://github.com/hashicorp/terraform/archive/v0.11.1.tar.gz'
  source_sha256 'da804e69e990226ee14dadbf33850c8b074d5e0782d56522b71d62c4c5c82cba'

  depends_on 'go' => :build

  def self.build
    system 'mkdir -p ../src/github.com/hashicorp/terraform'
    system 'cp -aT . ../src/github.com/hashicorp/terraform/'
    system 'mv ../src .'
    system 'export GOPATH=`pwd`; go get -u golang.org/x/tools/cmd/stringer'
    system 'export TMPDIR=/usr/local/tmp; export GOPATH=`pwd`; export PATH=$PATH:$GOPATH/bin; cd src/github.com/hashicorp/terraform/; make dev'
  end

  def self.install
    Dir.chdir 'src/github.com/hashicorp/terraform' do
      system "install -D -d #{CREW_DEST_DIR}/usr/local/bin"
      system "install -D -m 00755 bin/terraform #{CREW_DEST_DIR}/usr/local/bin/terraform"
    end
  end
end
