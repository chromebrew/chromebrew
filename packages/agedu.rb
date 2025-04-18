require 'buildsystems/cmake'

class Agedu < CMake
  description 'Unix utility for tracking down wasted disk space'
  homepage 'https://www.chiark.greenend.org.uk/~sgtatham/agedu/'
  version '20241013'
  license 'Copyright 2008 Simon Tatham. All rights reserved.'
  compatibility 'all'
  source_url 'https://www.chiark.greenend.org.uk/~sgtatham/agedu/agedu-20241013.3622eda.tar.gz'
  source_sha256 '3f77cb2e4dd64c100f7a7b0789a6c06cc16f23e7fe78c1451f5020dd823cf2f8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0cc1186dfe4a6b0079cdfd46c40654dd04e3494aa48a2db4fcfbf7b0f6ef27b5',
     armv7l: '0cc1186dfe4a6b0079cdfd46c40654dd04e3494aa48a2db4fcfbf7b0f6ef27b5',
       i686: 'd6f0c3671b9dd06835c9ff8f2d73e95c9ff61e14a915d41f9f1161076884cefa',
     x86_64: '1cb548694350a3bdd97252f51ee588b272733a2973a8db19fd797ace6a5a8042'
  })
end
