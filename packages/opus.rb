require 'buildsystems/meson'

class Opus < Meson
  description 'Opus is a totally open, royalty-free, highly versatile audio codec.'
  homepage 'https://opus-codec.org'
  version '1.5.2-1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/xiph/opus.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1df3cde37f4a58f6eae05fed8703d78769538936071a6ce577bfe8575b88a9aa',
     armv7l: '1df3cde37f4a58f6eae05fed8703d78769538936071a6ce577bfe8575b88a9aa',
       i686: '148b3ff34845a7880c8fe585d9882126deb69ccfdf3bdf330276f2d5a47e6c60',
     x86_64: 'ba1c94c977cb542d2f195251a12027bd221b08da056254910cf233c95f173579'
  })

  depends_on 'doxygen' => :build
  depends_on 'glibc' # R
  depends_on 'wget2' => :build

  git_fetchtags

  meson_options "#{CREW_MESON_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} \
                 -Dtests=disabled"

  def self.prebuild
    # Need to download models that do not fit in git.
    # https://github.com/xiph/opus/issues/317#issuecomment-1977822079
    system './autogen.sh'
  end
end
