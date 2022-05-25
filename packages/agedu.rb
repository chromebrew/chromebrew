require 'package'

class Agedu < Package
  description 'Unix utility for tracking down wasted disk space'
  homepage 'https://www.chiark.greenend.org.uk/~sgtatham/agedu/'
  version '20211129'
  license 'Copyright 2008 Simon Tatham. All rights reserved.'
  compatibility 'all'
  source_url 'https://www.chiark.greenend.org.uk/~sgtatham/agedu/agedu-20211129.8cd63c5.tar.gz'
  source_sha256 'ceaee592ef21b8cbb254aa7e9c5d22cefab24535e137618a4d0af591eba8339f'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/agedu/20211129_armv7l/agedu-20211129-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/agedu/20211129_armv7l/agedu-20211129-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/agedu/20211129_i686/agedu-20211129-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/agedu/20211129_x86_64/agedu-20211129-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0cc1186dfe4a6b0079cdfd46c40654dd04e3494aa48a2db4fcfbf7b0f6ef27b5',
     armv7l: '0cc1186dfe4a6b0079cdfd46c40654dd04e3494aa48a2db4fcfbf7b0f6ef27b5',
       i686: 'd6f0c3671b9dd06835c9ff8f2d73e95c9ff61e14a915d41f9f1161076884cefa',
     x86_64: '1cb548694350a3bdd97252f51ee588b272733a2973a8db19fd797ace6a5a8042'
  })

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake #{CREW_CMAKE_OPTIONS} .."
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
