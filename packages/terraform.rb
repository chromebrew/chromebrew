require 'package'

class Terraform < Package
  description 'Terraform is a tool for building, changing, and combining infrastructure safely and efficiently.'
  homepage 'https://www.terraform.io/'
  version '0.11.1'
  compatibility 'all'
  source_url 'https://github.com/hashicorp/terraform/archive/v0.11.1.tar.gz'
  source_sha256 'da804e69e990226ee14dadbf33850c8b074d5e0782d56522b71d62c4c5c82cba'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/terraform-0.11.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/terraform-0.11.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/terraform-0.11.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/terraform-0.11.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c02e4d1761a5b74e4811cda8746117c9b8a085ef020ab6a626d32fd8ccb01cbe',
     armv7l: 'c02e4d1761a5b74e4811cda8746117c9b8a085ef020ab6a626d32fd8ccb01cbe',
       i686: '52f1396eda1989af2be6b67598d793e64968ff9cc19a72341b8491b0007724f2',
     x86_64: 'cd1bb823657e6ab6199403db138ddf83141fbe4728d6801b5dae897e782aaf29',
  })

  depends_on 'go' => :build

  def self.build
    system 'mkdir -p ../src/github.com/hashicorp/terraform'
    system 'cp -aT . ../src/github.com/hashicorp/terraform/'
    system 'mv ../src .'
    system 'export GOPATH=`pwd`; go get -u golang.org/x/tools/cmd/stringer'
    system "export TMPDIR=#{CREW_PREFIX}/tmp; export GOPATH=`pwd`; export PATH=\$PATH:\$GOPATH/bin; cd src/github.com/hashicorp/terraform/; make dev"
  end

  def self.install
    Dir.chdir 'src/github.com/hashicorp/terraform' do
      system "install -D -m 00755 bin/terraform #{CREW_DEST_PREFIX}/bin/terraform"
    end
  end
end
