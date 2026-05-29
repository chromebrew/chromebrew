require 'buildsystems/meson'

class Blueprint_compiler < Meson
  description 'A markup language for GTK user interfaces'
  homepage 'https://gitlab.gnome.org/GNOME/blueprint-compiler'
  version "0.20.4-#{CREW_PY_VER}"
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/blueprint-compiler.git'
  git_hashtag "v#{version.gsub("-#{CREW_PY_VER}", '')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9f026160656f2fb8b95726762c8b101dc1655cf100f9dee1140d12427ae02022',
     armv7l: '9f026160656f2fb8b95726762c8b101dc1655cf100f9dee1140d12427ae02022',
     x86_64: 'ca8abfa6e4628ba727ee849914a8514aa620a7b5b5fdea6bfec475997c0bdaa1'
  })

  depends_on 'py3_pygobject' # R

  def self.patch
    patches = [
      # https://gitlab.gnome.org/GNOME/blueprint-compiler/-/work_items/254
      ['https://gitlab.gnome.org/GNOME/blueprint-compiler/-/merge_requests/314.diff',
       'f42df751f5a8bfc853faf67fddac33fe162afae71e9212021e1595b558c9d556']
    ]
    ConvenienceFunctions.patch(patches) if version.include?('0.20.4')
  end
end
