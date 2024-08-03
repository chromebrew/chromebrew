require 'buildsystems/cmake'

class Whatsapp_for_linux < Cmake
  description 'An unofficial WhatsApp desktop application for Linux.'
  homepage 'https://github.com/eneshecan/whatsapp-for-linux'
  version '1.6.5'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/eneshecan/whatsapp-for-linux.git'
  git_hashtag "v#{version}"

  depends_on 'intltool'
  depends_on 'gtkmm3'
  depends_on 'webkit2gtk_4'
  depends_on 'libayatana_appindicator'
  depends_on 'libcanberra'
  depends_on 'hunspell'
end
