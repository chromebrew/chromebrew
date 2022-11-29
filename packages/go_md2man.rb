# Adapted from Arch Linux go-md2man PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/go-md2man/trunk/PKGBUILD

require 'package'

class Go_md2man < Package
  description 'A markdown to manpage generator'
  homepage 'https://github.com/cpuguy83/go-md2man'
  version '2.0.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/cpuguy83/go-md2man/archive/v2.0.1.tar.gz'
  source_sha256 '889309ecf43e40d3a76d666b0259dcd71b340ea0fad003784ff3fe0b6c21990e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/go_md2man/2.0.1_armv7l/go_md2man-2.0.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/go_md2man/2.0.1_armv7l/go_md2man-2.0.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/go_md2man/2.0.1_x86_64/go_md2man-2.0.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e12a504971810dee421ca4657a4af3c1be3ca82d4e319896e48d180c708e7679',
     armv7l: 'e12a504971810dee421ca4657a4af3c1be3ca82d4e319896e48d180c708e7679',
     x86_64: 'e1980595f9ff429ed47c7d8a2f57e5bf8a20e1d83277c0331d330d98b8558e97'
  })

  depends_on 'go' => :build

  def self.build
    system "GOFLAGS='-buildmode=pie -mod=vendor -trimpath' CGO_LDFLAGS=$LDFLAGS go build -o go-md2man ."
    system './go-md2man -in=go-md2man.1.md -out=go-md2man.1'
  end

  def self.install
    FileUtils.mkdir_p %W[
      #{CREW_DEST_PREFIX}/bin
      #{CREW_DEST_MAN_PREFIX}/man1
    ]
    FileUtils.install 'go-md2man', "#{CREW_DEST_PREFIX}/bin/go-md2man", mode: 0o755
    FileUtils.install 'go-md2man.1', "#{CREW_DEST_MAN_PREFIX}/man1/go-md2man.1", mode: 0o644
  end
end
