require 'package'

class Libnsbmp < Package
  description 'Decoding library for BMP and ICO images in C'
  homepage 'https://www.netsurf-browser.org'
  version '0.1.6'
  license 'MIT'
  compatibility 'all'
  source_url 'https://download.netsurf-browser.org/libs/releases/libnsbmp-0.1.6-src.tar.gz'
  source_sha256 '79c49365f860ed451bfc4109eddec8de3e9b7ce5a3be069596bd2aa19279324f'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '19a2adc9830d6831ca4f3449f50dcd5ac06843b69030fb584a2f4394a3d7dee8',
     armv7l: '19a2adc9830d6831ca4f3449f50dcd5ac06843b69030fb584a2f4394a3d7dee8',
       i686: 'e9f5af9b770bb090ef346792193abea3bb0a3dd14ef9e08743bc9f1943684137',
     x86_64: 'b6f7dbcb2c44cfce36259885c1878ee9e4511290dd8a4299e30729795e030d44'
  })

  depends_on 'netsurf_buildsystem' => :build

  def self.build
    system "make PREFIX=#{CREW_PREFIX} COMPONENT_TYPE=lib-shared"
  end

  def self.install
    system "make install PREFIX=#{CREW_PREFIX} COMPONENT_TYPE=lib-shared DESTDIR=#{CREW_DEST_DIR}"
    case ARCH
    when 'x86_64'
      Dir.chdir CREW_DEST_PREFIX do
        FileUtils.mv 'lib/', 'lib64/'
      end
    end
  end
end
