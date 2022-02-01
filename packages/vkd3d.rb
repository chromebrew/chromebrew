require 'package'

class Vkd3d < Package
  description 'Vkd3d is a 3D graphics library built on top of Vulkan. It has an API very similar, but not identical, to Direct3D 12.'
  homepage 'https://wiki.winehq.org/Vkd3d/'
  version '1.2'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://dl.winehq.org/vkd3d/source/vkd3d-1.2.tar.xz'
  source_sha256 'b04b030fcbf0f2dacc933c76c74b449bffef1fc1a18d50254ef1ad3e380df96b'

  depends_on 'libxcb'
  depends_on 'spirv_headers' => :build
  depends_on 'spirv_tools'
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader'

  def self.build
    system "#{CREW_ENV_FNO_LTO_OPTIONS} ./configure #{CREW_OPTIONS} \
            --with-xcb \
            --with-spirv-tools"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
