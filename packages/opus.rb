require 'buildsystems/meson'

class Opus < Meson
  description 'Opus is a totally open, royalty-free, highly versatile audio codec.'
  homepage 'https://opus-codec.org'
  version '1.6.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/xiph/opus.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e7aaa3a6aa87f50da387fa639b279ffdfd27a462eed059d686fdd6444d98747b',
     armv7l: 'e7aaa3a6aa87f50da387fa639b279ffdfd27a462eed059d686fdd6444d98747b',
       i686: '0ee43847fcf37033641b71503ed2ba4159cb25e8a6c12628af6722adfcc9acbf',
     x86_64: '3d14e2f63dd73446938c06b8a7957e206bf067a4609d7ed8021cf6630dd2e7c2'
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
