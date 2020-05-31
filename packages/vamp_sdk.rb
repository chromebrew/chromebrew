require 'package'

class Vamp_sdk < Package
  description 'Vamp is an audio processing plugin system for plugins that extract descriptive information from audio data — typically referred to as audio analysis plugins or audio feature extraction plugins.'
  homepage 'https://vamp-plugins.org/'
  version '2.9.0'
  source_url 'https://code.soundsoftware.ac.uk/attachments/download/2588/vamp-plugin-sdk-2.9.0.tar.gz'
  source_sha256 'b72a78ef8ff8a927dc2ed7e66ecf4c62d23268a5d74d02da25be2b8d00341099'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vamp_sdk-2.9.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vamp_sdk-2.9.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vamp_sdk-2.9.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vamp_sdk-2.9.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fc53ab7e53a476611498b38139aaa3be69b39efe097ff97b5633b53d0883981c',
     armv7l: 'fc53ab7e53a476611498b38139aaa3be69b39efe097ff97b5633b53d0883981c',
       i686: 'd376a24518bb74e53f5c1556cd570b1e7e910e6679f8b87b1e3b0778e924d724',
     x86_64: 'cf7ca4db41a96a12eeb89c658153e4641101d10740dd4c89a6d3a66f289d2b5b',
  })

  depends_on 'libsndfile'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    if ARCH == 'x86_64'
      Dir.chdir "#{CREW_DEST_PREFIX}" do
        FileUtils.mv 'lib/', 'lib64/'
      end
    end
  end
end
