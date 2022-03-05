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
    aarch64: '4074c6158cb50c394690443722a06e90f385b886ecfaaf4c9c8395eb639f5351',
     armv7l: '4074c6158cb50c394690443722a06e90f385b886ecfaaf4c9c8395eb639f5351',
     x86_64: 'ba48983b018cbf9d7e985e987dca4bb7ac6216064373b5a69a57c42ffc4ff56b'
  })

  depends_on 'go'

  def self.build
    system "GOFLAGS='-buildmode=pie -mod=vendor -trimpath' CGO_LDFLAGS=$LDFLAGS go build -o go-md2man ."
    system './go-md2man -in=go-md2man.1.md -out=go-md2man.1'
  end

  def self.install
    system "install -Dm755 go-md2man #{CREW_DEST_PREFIX}/bin/go-md2man"
    system "install -Dm755 go-md2man.1 #{CREW_DEST_MAN_PREFIX}/man1/go-md2man.1"
  end
end
