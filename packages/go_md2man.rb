# Adapted from Arch Linux go-md2man PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/go-md2man/trunk/PKGBUILD

require 'package'

class Go_md2man < Package
  description 'A markdown to manpage generator'
  homepage 'https://github.com/cpuguy83/go-md2man'
  version '2.0.2'
  license 'MIT'
  compatibility 'all'
  # source_url 'https://github.com/cpuguy83/go-md2man.git'
  # git_hashtag 'ef170e57c3b8f5ed8527eb619ae9241127a94153'
  source_url 'https://github.com/cpuguy83/go-md2man/archive/v2.0.2.tar.gz'
  source_sha256 '2f52e37101ea2734b02f2b54a53c74305b95b3a9a27792fdac962b5354aa3e4a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/go_md2man/2.0.2_armv7l/go_md2man-2.0.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/go_md2man/2.0.2_armv7l/go_md2man-2.0.2-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/go_md2man/2.0.2_x86_64/go_md2man-2.0.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b75e68e484db893603d85a3d72eaa2d32f2b5f342ac3b1b94202b664e08503f9',
     armv7l: 'b75e68e484db893603d85a3d72eaa2d32f2b5f342ac3b1b94202b664e08503f9',
     x86_64: '28e764d9db64f7d5f4a4effdebcc9ba8cee3a52f42193789cd9e173bc31c187e'
  })

  depends_on 'go' => :build
  depends_on 'glibc' # R

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
