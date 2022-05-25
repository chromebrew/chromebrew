require 'package'

class Git_lfs < Package
  description 'Git extension for versioning large files'
  homepage 'https://git-lfs.github.com'
  version '2.13.2'
  license 'AGPL-3'
  compatibility 'all'
  source_url "https://github.com/git-lfs/git-lfs/releases/download/v#{version}/git-lfs-v#{version}.tar.gz"
  source_sha256 '782e6275df9ca370730945112e16a0b8c64b9819f0b61fae52ba1ebbc8dce2d5'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git_lfs/2.13.2_armv7l/git_lfs-2.13.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git_lfs/2.13.2_armv7l/git_lfs-2.13.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git_lfs/2.13.2_i686/git_lfs-2.13.2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git_lfs/2.13.2_x86_64/git_lfs-2.13.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '28dd4fe263e71d34c1af024f7955e975a7baa239b25d8fed9982cce213248d5a',
     armv7l: '28dd4fe263e71d34c1af024f7955e975a7baa239b25d8fed9982cce213248d5a',
       i686: 'df546bc44ec2978165ffa8c0b31bad8504df93e86e52aac58288df707692a4af',
     x86_64: '6078b2db1ac18189f96da4aa5cd9ddd78db5575e89080e85824a08b2dc21e958'
  })

  depends_on 'go' => :build
  depends_on 'go_tools' => :build

  def self.build
    system 'gem install -N ronn'
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CGO_CPPFLAGS=${CXXFLAGS} \
      CGO_CFLAGS=${CFLAGS} \
      CGO_CXXFLAGS=${CXXFLAGS} \
      CGO_LDFLAGS=${LDFLAGS} \
      GOFLAGS='-buildmode=pie -trimpath -mod=vendor -modcacherw -ldflags=-linkmode=external' \
      go generate ./commands && go build ."
    system 'make man'
    system 'gem uninstall --ignore-dependencies ronn'
  end

  def self.install
    system "install -Dm755 git-lfs #{CREW_DEST_PREFIX}/bin/git-lfs"
    system "install -Dm644 -t #{CREW_DEST_MAN_PREFIX}/man1 man/*.1"
    system "install -Dm644 -t #{CREW_DEST_MAN_PREFIX}/man5 man/*.5"
  end
end
