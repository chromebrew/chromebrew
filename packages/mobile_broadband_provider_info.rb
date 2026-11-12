require 'buildsystems/meson'

class Mobile_broadband_provider_info < Meson
  description 'Network Management daemon'
  homepage 'https://gitlab.gnome.org/GNOME/mobile-broadband-provider-info'
  version '20261111'
  license 'CC-PD'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/mobile-broadband-provider-info.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '628aa457b3ce317ac80575531d3005505aa9f044c573966dd87995d0725fd7e7',
     armv7l: '628aa457b3ce317ac80575531d3005505aa9f044c573966dd87995d0725fd7e7',
     x86_64: '008e0ab7d46c8b0986d1624eddbcfcf6e585fa47cad0823d48dcb84d4ecad4a0'
  })

  depends_on 'libxslt' => :build

  gnome
end
