require 'buildsystems/autotools'

class Xmessage < Autotools
  description 'Xmessage displays a message or query in a window.'
  homepage 'https://www.x.org/wiki/'
  version '1.0.7'
  license 'MIT-with-advertising'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xmessage.git'
  git_hashtag "xmessage-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd94321b3643048f45bb7f6081a6b3062ff4022cf1c8a2f2105ce46899731c139',
     armv7l: 'd94321b3643048f45bb7f6081a6b3062ff4022cf1c8a2f2105ce46899731c139',
     x86_64: '325090fbac9447bc8665d39bf741a286a527d81ec02919d1bcc2c22cf6a37594'
  })

  depends_on 'glibc' => :library
  depends_on 'libx11' => :library
  depends_on 'libxaw' => :library
  depends_on 'libxt' => :library
end
