require 'buildsystems/meson'

class Json_c < Meson
  description 'JSON-C implements a reference counting object model that allows you to easily construct JSON objects in C, output them as JSON formatted strings and parse JSON formatted strings back into the C representation of JSON objects.'
  homepage 'https://github.com/json-c/json-c'
  version '0.19-20260627'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/json-c/json-c.git'
  git_hashtag "json-c-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '959b5d14ef6e79d305999444949f7f5bf0c5ead33dc76208cad2440377b0aff5',
     armv7l: '959b5d14ef6e79d305999444949f7f5bf0c5ead33dc76208cad2440377b0aff5',
       i686: 'b07742a4a1f29d87d7d20f7e15cb76a22e6152b58eafa4661d3ca720a10471e0',
     x86_64: '84fcc0951742e0ca05356cbacb6c7702d19589d15adaffc3304aca192eaf4a58'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'graphviz' => :build
  depends_on 'libbsd' => :library

  meson_options '-Denable_threading=true'

  meson_install_extras do
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libjson-c.so", "#{CREW_DEST_LIB_PREFIX}/libjson-c.so.3"
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libjson-c.so", "#{CREW_DEST_LIB_PREFIX}/libjson-c.so.4"
  end

  def self.patch
    patches = [
      # Fix for pkgconf generation 1
      ['https://github.com/json-c/json-c/commit/56a0e3f478c879c6a3f07b2ca6efa1ad2130d0e6.patch', '93cd4b535eee6a9a8539d78c05c0283ca63eb3a07d2c9a70b42412d1a72eec1b'],
      # Fix pkgconf generation 2
      ['https://github.com/json-c/json-c/commit/2419dbd2ead3e45686978bc481384a93cb46f991.patch', '24b6928e87f388f633b51b98025c15ca6cd40c4cd388278cbb98bd06c64be719']
    ]
    ConvenienceFunctions.patch(patches) if version == '0.19-20260627'
  end
end
