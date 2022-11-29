# Adapted from Arch Linux runc PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/runc/trunk/PKGBUILD

require 'package'

class Runc < Package
  description 'CLI tool for managing OCI compliant containers'
  homepage 'https://runc.io/'
  version '1.1.0'
  license 'Apache'
  compatibility 'all'
  source_url 'https://github.com/opencontainers/runc.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/runc/1.1.0_armv7l/runc-1.1.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/runc/1.1.0_armv7l/runc-1.1.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/runc/1.1.0_x86_64/runc-1.1.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9b52e4e308ee6f28bfcad10dc3aed23543d6c323199a8ebdd5d9262b80f0438d',
     armv7l: '9b52e4e308ee6f28bfcad10dc3aed23543d6c323199a8ebdd5d9262b80f0438d',
     x86_64: '5652d483b9512919ebd0afb8095dc267368307e6ae592f8edcbc87caeab41289'
  })

  depends_on 'libseccomp'
  depends_on 'go' => :build
  depends_on 'go_md2man' => :build

  def self.build
    system "BUILDTAGS='seccomp apparmor' \
      CGO_CPPFLAGS=${CPPFLAGS} \
      CGO_CFLAGS=${CFLAGS} \
      CGO_CXXFLAGS=${CXXFLAGS} \
      CGO_LDFLAGS=${LDFLAGS} \
      GOFLAGS='-trimpath -mod=readonly -modcacherw' \
      make runc man"
  end

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/bin/ #{CREW_DEST_MAN_PREFIX}/man8
                         #{CREW_DEST_PREFIX}/share/bash-completion/completions]
    system "install -Dm755 runc #{CREW_DEST_PREFIX}/bin/runc"
    system "install -Dm644 contrib/completions/bash/runc \
      #{CREW_DEST_PREFIX}/share/bash-completion/completions/runc"
    system "install -m644 man/man8/*.8 #{CREW_DEST_MAN_PREFIX}/man8"
  end
end
