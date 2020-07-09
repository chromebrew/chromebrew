require 'package'

class Xa < Package
  description 'xa is a high-speed, two-pass portable cross-assembler.'
  homepage 'https://www.floodgap.com/retrotech/xa/'
  version '2.3.11'
  compatibility 'all'
  source_url 'https://www.floodgap.com/retrotech/xa/dists/xa-2.3.11.tar.gz'
  source_sha256 '32f2164c99e305218e992970856dd8e2309b5cb6ac4758d7b2afe3bfebc9012d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xa-2.3.11-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xa-2.3.11-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xa-2.3.11-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xa-2.3.11-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4e9da9aa44ec5d58c597d5f3fcbba2ba3786002e0da6adebe381c4c70f90cda6',
     armv7l: '4e9da9aa44ec5d58c597d5f3fcbba2ba3786002e0da6adebe381c4c70f90cda6',
       i686: '9b60a965368eb960b9d06fd80c47be53e30b3a622c966b20a0f7eb04ae051e70',
     x86_64: '8ea3b2dd25b9b6af9401c653e84ea67c1ba7ce2228d9d8e83d6ab8e3732893d7',
  })

  def self.patch
    system "sed -i 's,DESTDIR = /usr/local,DESTDIR = #{CREW_DEST_PREFIX},' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', 'install'
  end
end
