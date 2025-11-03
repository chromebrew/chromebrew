require 'package'

class Blender < Package
  description 'Blender is the free and open source 3D creation suite.'
  homepage 'https://www.blender.org'
  version '4.5.4'
  license 'GPLv3+'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://download.blender.org/release/Blender#{version.sub(/\.\d+$/, '')}/blender-#{version}-linux-x64.tar.xz"
  source_sha256 '2e6ef8e99fc36327270429ddc8e7bad2859dd878a5a137d2e0bf0f02f6792505'

  # depends_on 'audaspace'
  depends_on 'boost' # R
  depends_on 'eigen'
  depends_on 'embree'
  depends_on 'ffmpeg'
  depends_on 'freetype'
  depends_on 'gmp' # R
  depends_on 'jack' # R
  depends_on 'libepoxy'
  depends_on 'libjpeg_turbo'
  depends_on 'libpng'
  depends_on 'sdl2' # R
  depends_on 'libsndfile' # R
  depends_on 'libtiff'
  depends_on 'libwebp' # R
  depends_on 'libx11' # R
  depends_on 'libxfixes' # R
  depends_on 'libxi' # R
  depends_on 'libxkbcommon' # R
  depends_on 'libxrender' # R
  depends_on 'libxxf86vm' # R
  depends_on 'openal' # R
  depends_on 'openexr' # R
  depends_on 'openimageio'
  depends_on 'openjpeg' # R
  depends_on 'pipewire' # R
  depends_on 'pugixml' # R
  depends_on 'pulseaudio' # R
  depends_on 'py3_numpy'
  depends_on 'py3_requests'
  depends_on 'python3'
  depends_on 'tbb' # R
  depends_on 'zlib'
  depends_on 'zstd'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/blender"
    FileUtils.install 'blender.desktop', "#{CREW_DEST_PREFIX}/share/applications/blender.desktop", mode: 0o644
    FileUtils.install 'blender.svg', "#{CREW_DEST_PREFIX}/share/icons/blender.svg", mode: 0o644
    FileUtils.ln_s "#{CREW_PREFIX}/share/blender/blender-launcher", "#{CREW_DEST_PREFIX}/bin/blender"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/blender"
  end
end
