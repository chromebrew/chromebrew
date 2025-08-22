require 'buildsystems/autotools'

class Berry < Autotools
  description 'Healthy, bite-sized window manager'
  homepage 'https://github.com/JLErvin/berry'
  version '0.1.13'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/JLErvin/berry.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'be99a832545c2b5c21fcfa583c00fdfc95c292d560255338a3a059cfd023fb82',
     armv7l: 'be99a832545c2b5c21fcfa583c00fdfc95c292d560255338a3a059cfd023fb82',
     x86_64: '7a8f5f9731eb17735192527c125a2fd4f3c41581be5d1b92d6c79dd9906e858d'
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
