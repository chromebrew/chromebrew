require 'buildsystems/meson'

class Ciano < Meson
  description 'A multimedia file converter focused on simplicity.'
  homepage 'https://robertsanseries.github.io/ciano/'
  version '0.2.4'
  license 'GPL-3.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/robertsanseries/ciano.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ebc69899fc8007cd826b2a227c2e8d00c859d6260d724820cf272ed62297455c',
     armv7l: 'ebc69899fc8007cd826b2a227c2e8d00c859d6260d724820cf272ed62297455c',
     x86_64: '23ef871ad2e09132fd21bde883466010f39370703866887d8d8bf869fc5dc733'
  })

  gnome

  depends_on 'py3_meson' => :build
  depends_on 'ffmpeg' # R
  depends_on 'imagemagick7' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'granite' # R
  depends_on 'gsettings_desktop_schemas' # R
  depends_on 'gtk3' # R
  depends_on 'libgee' # R
  depends_on 'pango' # R
  depends_on 'vala'

  meson_install_extras do
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/com.github.robertsanseries.ciano", "#{CREW_DEST_PREFIX}/bin/ciano"
  end

  def self.postinstall
    ExitMessage.add "\nType 'ciano' to get started.\n".lightblue
  end
end
