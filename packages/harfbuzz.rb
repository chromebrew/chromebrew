require 'package'

class Harfbuzz < Package
  description 'HarfBuzz is an OpenType text shaping engine.'
  homepage 'https://www.freedesktop.org/wiki/Software/HarfBuzz/'
  @_ver = '4.0.0'
  version @_ver
  license 'Old-MIT, ISC and icu'
  compatibility 'all'
  source_url 'https://github.com/harfbuzz/harfbuzz.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/4.0.0_armv7l/harfbuzz-4.0.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/4.0.0_armv7l/harfbuzz-4.0.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/4.0.0_i686/harfbuzz-4.0.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/harfbuzz/4.0.0_x86_64/harfbuzz-4.0.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0efa561d9870cb8eab422f276de82ecfd37167abe29f8d183f01d6f330536940',
     armv7l: '0efa561d9870cb8eab422f276de82ecfd37167abe29f8d183f01d6f330536940',
       i686: 'bfa15553901736cc2a1b05f85b221763c0c3111b8da8bcf19d2c036bb595a8d7',
     x86_64: '32d005399a05f64424ab682f77550c272f6df0932a7756b91cda3cb2cf732c8a'
  })

  depends_on 'cairo' => :build
  depends_on 'chafa' => :build
  depends_on 'glib' => :build
  depends_on 'gobject_introspection'
  depends_on 'freetype_sub' => :build
  # Hopefully regular freetype gets pulled in by some other package dep.
  depends_on 'py3_six' => :build
  depends_on 'graphite' => :build
  no_env_options

  def self.build
    @device = JSON.parse(File.read("#{CREW_CONFIG_PATH}device.json"), symbolize_names: true)
    if @device[:installed_packages].any? do |elem| elem[:name] == 'freetype' end
      puts 'Please reinstall freetype_sub after other dependencies are installed before building.'.yellow
    end
    case ARCH
    when 'aarch64', 'armv7l'
      @meson_options = CREW_MESON_OPTIONS
    when 'i686', 'x86_64'
      @meson_options = CREW_MESON_OPTIONS.gsub('-Dc_args=\'-O2', '-Dc_args=\'-O2 -fuse-ld=mold').gsub('-Dcpp_args=\'-O2',
                                                                                                      '-Dcpp_args=\'-O2 -fuse-ld=mold')
    end
    system "meson #{@meson_options} \
    --default-library=both \
    -Dintrospection=enabled \
    -Dbenchmark=disabled \
    -Dtests=disabled \
    -Dgraphite2=enabled \
    -Dfreetype=enabled \
    -Dragel_subproject=true \
    -Ddocs=disabled \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja install -C builddir"
  end
end
