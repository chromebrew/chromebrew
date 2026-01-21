require 'package'

class Libcss < Package
  description 'CSS parser and selection engine, written in C'
  homepage 'https://www.netsurf-browser.org'
  version '0.9.2'
  license 'MIT'
  compatibility 'all'
  source_url "https://download.netsurf-browser.org/libs/releases/libcss-#{version}-src.tar.gz"
  source_sha256 '2df215bbec34d51d60c1a04b01b2df4d5d18f510f1f3a7af4b80cddb5671154e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2ed5acd3592424cf2bb3280570ea27a707e8dc8a803819dec31132f599baa5fc',
     armv7l: '2ed5acd3592424cf2bb3280570ea27a707e8dc8a803819dec31132f599baa5fc',
       i686: '2f5285be52fa5955d6b322271a5aa82a7209ee2113b67a23fb137a4c99d0cedf',
     x86_64: 'f9186c282c557ba8d044a8df80d26840b959be3274b0f7933844f0602db2cff1'
  })

  depends_on 'glibc' # R
  depends_on 'libparserutils' # R
  depends_on 'libwapcaplet' # R
  depends_on 'netsurf_buildsystem' => :build

  @env = {
    'PREFIX' => CREW_PREFIX,
    'LIBDIR' => "lib#{CREW_LIB_SUFFIX}",
    'DESTDIR' => CREW_DEST_DIR,
    'COMPONENT_TYPE' => 'lib-shared'
  }

  def self.patch
    # Fix error: ‘calloc’ sizes specified with ‘sizeof’ in the earlier argument and not in the later argument.
    system "sed -i 's/sizeof(css_computed_style), 1/1, sizeof(css_computed_style)/' src/select/computed.c"
    system "sed -i 's/sizeof(struct css_node_data), 1/1, sizeof(struct css_node_data)/' src/select/select.c"
    system "sed -i 's/sizeof(css_select_ctx), 1/1, sizeof(css_select_ctx)/' src/select/select.c"
    system "sed -i 's/sizeof(css_bloom), CSS_BLOOM_SIZE/CSS_BLOOM_SIZE, sizeof(css_bloom)/' src/select/select.c"
  end

  def self.build
    system @env, 'make'
  end

  def self.install
    system @env, 'make install'
  end
end
