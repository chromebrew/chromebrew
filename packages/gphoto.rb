require 'buildsystems/autotools'

class Gphoto < Autotools
  description 'The gphoto2 commandline tool for accessing and controlling digital cameras.'
  homepage 'http://www.gphoto.org/'
  version '2.5.32'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/gphoto/gphoto2.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '05e47afcfc1416eaae1f94cabe5f34ef95321a3f559ab09162798376ed397f11',
     armv7l: '05e47afcfc1416eaae1f94cabe5f34ef95321a3f559ab09162798376ed397f11',
       i686: '4b2e14c9fc24acc7963ef86f1ac71d1a5fe84837589e800f1630ea5014be8ba7',
     x86_64: '15c44dd84d053db86ba8198727afc9f34f902a5fee5d00967144aaa57c69a5ff'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libexif' => :executable
  depends_on 'libgphoto' => :executable
  depends_on 'libjpeg_turbo' => :executable
  depends_on 'libtool' => :executable
  depends_on 'popt' => :executable
  depends_on 'readline' => :executable

  autotools_install_extras do
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/gphoto2", "#{CREW_DEST_PREFIX}/bin/gphoto"
  end

  run_tests
end
