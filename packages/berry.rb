require 'buildsystems/autotools'

class Berry < Autotools
  description 'Healthy, bite-sized window manager'
  homepage 'https://github.com/JLErvin/berry'
  version '0.1.12'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/JLErvin/berry.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '59add51bcb91e1bc310128f0f0735e9665ca38afa246b03eb9e8059426b4b6be',
     armv7l: '59add51bcb91e1bc310128f0f0735e9665ca38afa246b03eb9e8059426b4b6be',
     x86_64: '32d9f31e492cbd4606d59a12c18ee59e9634e3abc15257c47110f4f7ffeb1b4b'
  })

  depends_on 'fontconfig' # R
  depends_on 'freetype'
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libx11'
  depends_on 'libxft' # R
  depends_on 'libxinerama' # R
  depends_on 'sommelier'

  def self.postinstall
    ExitMessage.add 'A hotkey system such as sxhkd is needed in order to use berry as a WM'.lightblue
  end
end
