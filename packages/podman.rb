# Adapted from Arch Linux podman PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/podman/trunk/PKGBUILD

require 'package'

class Podman < Package
  description 'Tool and library for running OCI-based containers in pods'
  homepage 'https://github.com/containers/podman'
  version '4.3.1'
  license 'Apache'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/containers/podman.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/podman/4.3.1_armv7l/podman-4.3.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/podman/4.3.1_armv7l/podman-4.3.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/podman/4.3.1_x86_64/podman-4.3.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ea6501490b86313279d0982e403a1665ba56713c95ad48f74f8b1bc929661ade',
     armv7l: 'ea6501490b86313279d0982e403a1665ba56713c95ad48f74f8b1bc929661ade',
     x86_64: '883d116f8ee1092982a62076a2dee2eb7770f0c9e824b059e90db8e99d998ff5'
  })

  depends_on 'btrfsprogs' => :build
  depends_on 'catatonit'
  depends_on 'containers_common' # L
  depends_on 'glibc' # R
  depends_on 'go' => :build
  depends_on 'go_md2man' => :build
  depends_on 'gpgme' # R
  depends_on 'libseccomp' # R

  def self.patch
    system "sed -i 's,/usr/libexec/podman/catatonit,#{CREW_PREFIX}/bin/catatonit,g' vendor/github.com/containers/common/pkg/config/default.go"
  end

  def self.build
    system "GOFLAGS='-buildmode=pie -trimpath' make EXTRA_LDFLAGS='-s -w -linkmode=external'"
    system 'make docker-docs'
  end

  def self.install
    system "make install install.completions install.docker-full DESTDIR=#{CREW_DEST_DIR} PREFIX=#{CREW_PREFIX} LIBEXECDIR=#{CREW_LIB_PREFIX}"
    # Remove conflicts with containers_common.
    FileUtils.remove_dir "#{CREW_DEST_MAN_PREFIX}/man5"
  end
end
