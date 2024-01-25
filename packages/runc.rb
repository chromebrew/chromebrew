# Adapted from Arch Linux runc PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/runc/trunk/PKGBUILD

require 'package'

class Runc < Package
  description 'CLI tool for managing OCI compliant containers'
  homepage 'https://runc.io/'
  version '1.1.7'
  license 'Apache'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/opencontainers/runc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9b26302b3cd4803d516c069901471f81ba5a043bc4e9873a87b3992f618484c8',
     armv7l: '9b26302b3cd4803d516c069901471f81ba5a043bc4e9873a87b3992f618484c8',
     x86_64: '8302c85fcfabe3766323a583c65b578c8af6c0ada28e44f247d82b1c9d4dcbb4'
  })

  depends_on 'libseccomp' # R
  depends_on 'go' => :build
  depends_on 'go_md2man' => :build
  depends_on 'glibc' # R

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
    FileUtils.install 'runc', "#{CREW_DEST_PREFIX}/bin/runc", mode: 0o755
    FileUtils.install 'contrib/completions/bash/runc',
                      "#{CREW_DEST_PREFIX}/share/bash-completion/completions/runc", mode: 0o644
    FileUtils.install Dir['man/man8/*.8'], "#{CREW_DEST_MAN_PREFIX}/man8/", mode: 0o644
  end
end
