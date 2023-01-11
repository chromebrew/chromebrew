# Adapted from Arch Linux runc PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/runc/trunk/PKGBUILD

require 'package'

class Runc < Package
  description 'CLI tool for managing OCI compliant containers'
  homepage 'https://runc.io/'
  version '1.1.4'
  license 'Apache'
  compatibility 'all'
  source_url 'https://github.com/opencontainers/runc.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/runc/1.1.4_armv7l/runc-1.1.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/runc/1.1.4_armv7l/runc-1.1.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/runc/1.1.4_i686/runc-1.1.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/runc/1.1.4_x86_64/runc-1.1.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b096c698a50db38a576e30bc84c1a589c72384972bf70df01e91be76b19291c5',
     armv7l: 'b096c698a50db38a576e30bc84c1a589c72384972bf70df01e91be76b19291c5',
       i686: '25956d2f26c123d9ddb1fd14ef1866913ea558ae2ea23c7932757e9024b2c060',
     x86_64: '9e16ffb288b01c5d8245bcd21bb83e0aa8e3159c91546314e4189636831d71ea'
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
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/bin/ #{CREW_DEST_MAN_PREFIX}/man8
                         #{CREW_DEST_PREFIX}/share/bash-completion/completions]
    FileUtils.install 'runc', "#{CREW_DEST_PREFIX}/bin/runc", mode: 0o755
    FileUtils.install 'contrib/completions/bash/runc',
                      "#{CREW_DEST_PREFIX}/share/bash-completion/completions/runc", mode: 0o644
    FileUtils.install Dir['man/man8/*.8'], "#{CREW_DEST_MAN_PREFIX}/man8/", mode: 0o644
  end
end
