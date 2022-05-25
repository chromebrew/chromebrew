# Adapted from Arch Linux go-md2man PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/go-md2man/trunk/PKGBUILD

require 'package'

class Go_md2man < Package
  description 'A markdown to manpage generator'
  homepage 'https://github.com/cpuguy83/go-md2man'
  version '2.0.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/cpuguy83/go-md2man/archive/v2.0.2.tar.gz'
  source_sha256 '2f52e37101ea2734b02f2b54a53c74305b95b3a9a27792fdac962b5354aa3e4a'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/go_md2man/2.0.2_armv7l/go_md2man-2.0.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/go_md2man/2.0.2_armv7l/go_md2man-2.0.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/go_md2man/2.0.2_i686/go_md2man-2.0.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/go_md2man/2.0.2_x86_64/go_md2man-2.0.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8751befe1a9d1dbc4c69cb44a5fc4a91c8ef6b50ad8393e9b0f62acf101e56ae',
     armv7l: '8751befe1a9d1dbc4c69cb44a5fc4a91c8ef6b50ad8393e9b0f62acf101e56ae',
       i686: '089a75730ade35a9e5fdbbf0dce36b00d8561f8110ed39f99d4537deaf1e7f63',
     x86_64: 'd498f230de0b11cffdb3399d38de32ced680350477baa14bbccea07316aff083'
  })

  depends_on 'go' => :build
  depends_on 'glibc' # R

  def self.build
    system 'make'
    system 'bin/go-md2man -in=go-md2man.1.md -out=go-md2man.1'
  end

  def self.install
    FileUtils.mkdir_p %W[
      #{CREW_DEST_PREFIX}/bin
      #{CREW_DEST_MAN_PREFIX}/man1
    ]
    FileUtils.install 'bin/go-md2man', "#{CREW_DEST_PREFIX}/bin/go-md2man", mode: 0o755
    FileUtils.install 'go-md2man.1', "#{CREW_DEST_MAN_PREFIX}/man1/go-md2man.1", mode: 0o644
  end
end
