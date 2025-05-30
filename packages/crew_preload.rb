# This package creates a /usr/local/lib64 directory on armv7l/aarch64
# systems to handle the aarch64 crew-preload.so being installed to
# handle the default system aarch64 binaries now present on recent
# multiarch aarch64/armv7l based ARM ChromeOS milestones.
require 'package'

class Crew_preload < Package
  description 'Chromebrew LD_PRELOAD library to allow a mixed glibc environment.'
  homepage 'https://github.com/chromebrew/crew-package-glibc'
  version '2.41-5'
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '56cdef1fbaf0fc792f3612dd2356fc0fd96e35babaa2afcfc48069183b81c203',
     armv7l: '56cdef1fbaf0fc792f3612dd2356fc0fd96e35babaa2afcfc48069183b81c203',
       i686: 'b19f235f07480a309d06ebd0107a9cb510ab01ac5ac975c734be62ab156d9da1',
     x86_64: 'ff4fb4407dd4337b74606272cab7f1e8cdafa0c99e9bb7e07485c503bbbac267'
  })

  conflicts_ok
  no_fhs if %w[aarch64 armv7l].include?(ARCH)
  no_source_build
  no_strip

  def self.install
    case ARCH
    when 'aarch64', 'armv7l'
    downloader 'https://github.com/chromebrew/crew-package-glibc/raw/refs/heads/main/prebuilt/crew-preload-aarch64.so', 'e0906586ae49176f086e2e2afd127bc7e5b8dab3f348e26acf8c68fe172a6473'
    downloader 'https://github.com/chromebrew/crew-package-glibc/raw/refs/heads/main/prebuilt/crew-preload-armv7l.so', 'fd616c27b51411178057c78fb5bf93069ca0292532cda9e6f78b3fe129f6ddeb'
    when 'i686'
      downloader 'https://github.com/chromebrew/crew-package-glibc/raw/refs/heads/main/prebuilt/crew-preload-i686.so', '03764fba6b8dd0e4abad9bbf040426acb51a66b84be6e833999ee31e73a4fc3f'
    when 'x86_64'
      downloader 'https://github.com/chromebrew/crew-package-glibc/raw/refs/heads/main/prebuilt/crew-preload-x86_64.so', 'b5f8c4d8b82c8c74799bec647687b6510eb405564e725f15ef3ff62a7c0e256e'
    end
    
    # install crew-preload
    FileUtils.install "crew-preload-#{ARCH}.so", File.join(CREW_DEST_LIB_PREFIX, 'crew-preload.so'), mode: 0o755
    # Install crew-preload to handle multiarch ARM systems.
    FileUtils.install 'crew-preload-aarch64.so', File.join(CREW_DEST_PREFIX, 'lib64/crew-preload.so'), mode: 0o755 if %w[aarch64 armv7l].include?(ARCH)
  end
end
