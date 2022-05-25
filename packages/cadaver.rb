require 'package'

class Cadaver < Package
  description 'cadaver is a command-line WebDAV client for Unix. It supports file upload, download, on-screen display, namespace operations (move/copy), collection creation and deletion, and locking operations.'
  homepage 'https://notroj.github.io/cadaver/'
  version '0.24'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://notroj.github.io/cadaver/cadaver-0.24.tar.gz'
  source_sha256 '46cff2f3ebd32cd32836812ca47bcc75353fc2be757f093da88c0dd8f10fd5f6'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cadaver/0.24_armv7l/cadaver-0.24-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cadaver/0.24_armv7l/cadaver-0.24-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cadaver/0.24_x86_64/cadaver-0.24-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4b9e175b449294a4d73a7cf269d57612486696aec1c5e33963b612fa1f820159',
     armv7l: '4b9e175b449294a4d73a7cf269d57612486696aec1c5e33963b612fa1f820159',
     x86_64: 'b2ff640177c15881965eb00793da50f184d1a636f65353cdf5079e92bb7d80e0'
  })

  depends_on 'neon'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
