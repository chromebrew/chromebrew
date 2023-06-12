require 'package'

class Graphene < Package
  description 'A thin layer of graphic data types'
  homepage 'https://github.com/ebassi/graphene'
  version '1.10.8'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ebassi/graphene.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphene/1.10.8_armv7l/graphene-1.10.8-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphene/1.10.8_armv7l/graphene-1.10.8-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphene/1.10.8_i686/graphene-1.10.8-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphene/1.10.8_x86_64/graphene-1.10.8-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9ae35576dbac03a5150ef70c8a0a22321ed506f960fc4dd0153e90fc6b1cd8e0',
     armv7l: '9ae35576dbac03a5150ef70c8a0a22321ed506f960fc4dd0153e90fc6b1cd8e0',
       i686: '7afe1ad210a306e68fc4fa6e2c49caac0fe583f7671fb4116eb80492c1c9263a',
     x86_64: 'ca6f6733df788af3d4cec704a67b2d07ecb91ed188e3edf5067b1e85e24e7264'
  })

  depends_on 'gobject_introspection' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} \
      -Darm_neon=true \
      -Dinstalled_tests=false \
      -Dtests=false \
      builddir"
    system 'meson configure builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
