require 'buildsystems/autotools'

class Lm_sensors < Autotools
  description 'Collection of user space tools for general SMBus access and hardware monitoring'
  homepage 'https://hwmon.wiki.kernel.org/lm_sensors'
  version '3-6-2'
  license 'GPL-2+ and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/lm-sensors/lm-sensors.git'
  git_hashtag "V#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '203b3a8d9e69f49e957c43b58e7abea5e3aeff6fae479af48e1195f68df20144',
     armv7l: '203b3a8d9e69f49e957c43b58e7abea5e3aeff6fae479af48e1195f68df20144',
       i686: '70e9293d7e9f4cc14b42ef2a2056360593b182fb05052d981c43290acc5397fe',
     x86_64: '66c68207d359385dcf8f818fedffde6972a4a2529c6b7ea42676646aba632c6c'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libiconv' => :executable

  def self.build
    system "sed -i 's/-Llib -lsensors/-Llib -lsensors -liconv/g' prog/sensors/Module.mk"
    system "sed -i \"/LIBDIR :=/c LIBDIR := #{CREW_LIB_PREFIX}\" Makefile"
    system "sed -i \"/ETCDIR :=/c ETCDIR := #{CREW_PREFIX}\/etc\" Makefile"
    system "make PREFIX=#{CREW_PREFIX}"
  end
end
