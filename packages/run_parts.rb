# Adapted from Arch Linux run-parts PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/run-parts/trunk/PKGBUILD

require 'package'

class Run_parts < Package
  description 'run scripts or programs in a directory'
  homepage 'https://packages.qa.debian.org/d/debianutils.html'
  version '5.24'
  license 'GPL'
  compatibility 'all'
  source_url 'https://salsa.debian.org/debian/debianutils.git'
  git_hashtag "debian/#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8f2583ea031ebd21ce11282d050c9f1f10dd55f0e722d12d43d960f05cc18e85',
     armv7l: '8f2583ea031ebd21ce11282d050c9f1f10dd55f0e722d12d43d960f05cc18e85',
       i686: '73c4f5e1358bc8a69b19feec0e6d6bddfb4f42a1df51a2649eafe54b5c169fbd',
     x86_64: 'f159703cc1e1af9eb5d388d2375f99b442d8bca19b0f94b2a28206498b79c7df'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'po4a' => :build

  def self.build
    system 'autoreconf -fiv'
    system "./configure #{CREW_CONFIGURE_OPTIONS}"
    system 'make run-parts'
  end

  def self.install
    FileUtils.install 'run-parts', "#{CREW_DEST_PREFIX}/bin/run-parts", mode: 0o755
    FileUtils.install 'run-parts.8', "#{CREW_DEST_MAN_PREFIX}/man8/run-parts.8", mode: 0o644
  end
end
