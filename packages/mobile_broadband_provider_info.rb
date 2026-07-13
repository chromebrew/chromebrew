require 'buildsystems/meson'

class Mobile_broadband_provider_info < Meson
  description 'Network Management daemon'
  homepage 'https://gitlab.gnome.org/GNOME/mobile-broadband-provider-info'
  version '20240407'
  license 'CC-PD'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/mobile-broadband-provider-info.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dded72b0145848af57f0572e89570734058b44cca038e1d096ea734dbd6b8812',
     armv7l: 'dded72b0145848af57f0572e89570734058b44cca038e1d096ea734dbd6b8812',
     x86_64: '47a969f93e38f2d30de24d3da415aba252f46d0b7e2ae443275bcbb852177515'
  })

  depends_on 'libxslt' => :build

  gnome
end
