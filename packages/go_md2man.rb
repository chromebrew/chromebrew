# Adapted from Arch Linux go-md2man PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/go-md2man/trunk/PKGBUILD

require 'package'

class Go_md2man < Package
  description 'A markdown to manpage generator'
  homepage 'https://github.com/cpuguy83/go-md2man'
  version '2.0.7'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/cpuguy83/go-md2man.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4c797ea4bde34213f667d64de5d54e38009cb1362e7eedf7f209a983c952ae9e',
     armv7l: '4c797ea4bde34213f667d64de5d54e38009cb1362e7eedf7f209a983c952ae9e',
       i686: '158e87ea00279b74b886e43107aed401822824f05dec239d7e7c6c49e641a43e',
     x86_64: 'ef3804479d9b329807f3a8ddb02ce109265f7f48154a64ced4ba7c12a6197148'
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
