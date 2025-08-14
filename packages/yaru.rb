require 'package'

class Yaru < Package
  description 'Yaru default ubuntu theme'
  homepage 'https://github.com/ubuntu/yaru'
  version '25.10.1-0ubuntu1'
  license 'GPL-3 and CC-BY-SA-4.0'
  compatibility 'all'
  source_url "https://github.com/ubuntu/yaru/archive/refs/tags/#{version}.tar.gz"
  source_sha256 '8cbbb1fcc7fa1e46e48d870cc1f941069e8213ac53200001aa9548ad79086836'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '41ab422c7136ed3f8c6c959687a7808615624857d885a58cc366bf3aeafcacb8',
     armv7l: '41ab422c7136ed3f8c6c959687a7808615624857d885a58cc366bf3aeafcacb8',
       i686: 'a87c2a4231a968a2d4bb30283d1a84103ddf225651444368a173b30472a3a398',
     x86_64: 'dc2b68a4a1c4a0c5a2efe8ee180e5d773629e61edeaa543bc7ef45bc1b91348c'
  })

  depends_on 'sassc'

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Dubuntu-unity=true \
      build"
    system 'meson configure build'
    system 'ninja -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
