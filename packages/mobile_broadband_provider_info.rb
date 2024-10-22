require 'buildsystems/meson'

class Mobile_broadband_provider_info < Meson
  description 'Network Management daemon'
  homepage 'https://gitlab.gnome.org/GNOME/mobile-broadband-provider-info'
  version '20240316'
  license 'CC-PD'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/mobile-broadband-provider-info.git'
  git_hashtag 'df3c25cf6f8257805e77effdcbdaea10adc9419f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '44259ceaf722de3e14fe73303d5518309d3252e9dac2df2a8dd005c2de5ec845',
     armv7l: '44259ceaf722de3e14fe73303d5518309d3252e9dac2df2a8dd005c2de5ec845',
     x86_64: 'ba3e807317fa0f2bf2cf593fa927dff33eb383d9fe4152ee5ee3fcdd35f5f25c'
  })

  depends_on 'libxslt' => :build

  gnome
end
