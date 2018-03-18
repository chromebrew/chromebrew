require 'package'

class Packer < Package
  description 'Packer is an open source tool for creating identical machine images for multiple platforms from a single source configuration.'
  homepage 'https://www.packer.io/'
  version '1.2.1'

  case ARCH
  when 'aarch64'
    source_url 'https://releases.hashicorp.com/packer/1.2.1/packer_1.2.1_linux_arm64.zip'
    source_sha256 '8bbd20ad2b7065394b5d8b99b5a1dd73c7a9a07fae5f53ed4c95fccbe5d40ca5'
  when 'armv7l'
    source_url 'https://releases.hashicorp.com/packer/1.2.1/packer_1.2.1_linux_arm.zip'
    source_sha256 'dddedcd1cf8cb23d4c3b301219593dc66c4e407db270a08b514f2cefe07a0e49'
  when 'i686'
    source_url 'https://releases.hashicorp.com/packer/1.2.1/packer_1.2.1_linux_386.zip'
    source_sha256 'f0fa2c3f6ff63b8833240c3a35a5833e7a576a3060c9faaae11ad1f75ae576ac'
  when 'x86_64'
    source_url 'https://releases.hashicorp.com/packer/1.2.1/packer_1.2.1_linux_amd64.zip'
    source_sha256 'dd90f00b69c4d8f88a8d657fff0bb909c77ebb998afd1f77da110bc05e2ed9c3'
  end

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/packer-1.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/packer-1.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/packer-1.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/packer-1.2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7d187c36dbede0977f43f6a7e70ffedffddfe39e3920453f8a399d19789295ec',
     armv7l: '7d187c36dbede0977f43f6a7e70ffedffddfe39e3920453f8a399d19789295ec',
       i686: '40fddfa96ac9bcb343ed0e5f4bf607a04268293dd42dc480457f59e78ab186b8',
     x86_64: '7e9a790a93c8517ffd2a44c3cbca83d97bbfa5e6ac3c47cf37569c5d579fbdfc',
  })

  depends_on 'unzip' => :build

  def self.install
    system "install -Dm755 packer #{CREW_DEST_PREFIX}/bin/packer"
  end
end
