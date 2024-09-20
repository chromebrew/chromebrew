require 'buildsystems/meson'

class Cage < Meson
  description 'A kiosk compositor for Wayland'
  homepage 'https://www.hjdskes.nl/projects/cage/'
  version '0.1.5-eaeab71'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/Hjdskes/cage.git'
  git_hashtag 'eaeab71ffa3ab5884df09c5664c00e368ca2585e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9483e30cac7109814dd26487d318bcea15cf606dcba2ee8969255d670ea469cb',
     armv7l: '9483e30cac7109814dd26487d318bcea15cf606dcba2ee8969255d670ea469cb',
     x86_64: 'f97c9782490a2c82603b8f727eca3fff73695e1985e02e11a3dbc3ec45b01798'
  })

  depends_on 'glibc' # R
  depends_on 'libxkbcommon' # R
  depends_on 'pixman' => :build
  depends_on 'scdoc' => :build
  depends_on 'wayland' # R
  depends_on 'wayland_protocols' => :build
  depends_on 'wlroots' # R

  # https://github.com/cage-kiosk/cage/pull/313
  # Add support for wlroots v0.18
  def self.patch
    downloader 'https://patch-diff.githubusercontent.com/raw/cage-kiosk/cage/pull/313.patch', 'a953e61c3833cbde3df99f52aa1cb8b26020b871b0f85d9b874ebdd4640901b6'
    system 'git apply 313.patch'
  end
end
