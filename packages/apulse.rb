require 'package'

class Apulse < Package
  description 'PulseAudio emulation for ALSA'
  homepage 'https://github.com/i-rinat/apulse'
  version '0.1.12'
  source_url 'https://github.com/i-rinat/apulse/archive/v0.1.12.tar.gz'
  source_sha256 'cfcadfe971abd785ed3ca24e576fcbaade185525c1eda76daf32dbf298e52892'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/apulse-0.1.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/apulse-0.1.12-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/apulse-0.1.12-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/apulse-0.1.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '52eb3f770304cae5b214b6eec6f7d83bc5a268e0d4794672784cc50c5ea72e85',
     armv7l: '52eb3f770304cae5b214b6eec6f7d83bc5a268e0d4794672784cc50c5ea72e85',
       i686: '16c70c55c189ca558b024ee6d1b95a9e2ae2c9737acc56c58fa94237372546d0',
     x86_64: 'ebef3d93e0b8b10b595c830b84c2dfdc8a8bf26e117f83d1ebba8e967e5e0c30',
  })

  depends_on 'alsa_lib'
  depends_on 'glib'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DCMAKE_BUILD_TYPE=Release .."
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
