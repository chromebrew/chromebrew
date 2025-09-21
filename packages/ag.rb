require 'buildsystems/autotools'

class Ag < Autotools
  description 'The Silver Searcher. Very fast search similar to ack or grep. (ag)'
  homepage 'https://github.com/ggreer/the_silver_searcher'
  version '2.2.0-a61f178'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/ggreer/the_silver_searcher.git'
  git_hashtag 'a61f1780b64266587e7bc30f0f5f71c6cca97c0f'
  # git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '09933c508e32c656c1ded463c7267598a006f1ad94de33d950a3d0271e1f9c63',
     armv7l: '09933c508e32c656c1ded463c7267598a006f1ad94de33d950a3d0271e1f9c63',
       i686: 'b9634626e44e8d27599d450cf5ac6e78d812306758db892e3a8d50d0e5cec456',
     x86_64: '9bef4203af04d11d228978a19d00c4f1e2e505f9ddd20433447224fb27aa1a8b'
  })

  depends_on 'glibc' # R
  depends_on 'pcre' # R
  depends_on 'pkgconf' => :build
  depends_on 'xzutils' # R
  depends_on 'zlib' # R

  def self.patch
    patches = [
      # Fix ctype(3) abuse
      ['https://github.com/ggreer/the_silver_searcher/pull/1553.diff',
       '38ecf01778a20af3c7b849224a92828cef1c3df39ed83ddc12db70c276839e4c']
    ]
    ConvenienceFunctions.patch(patches)
  end
end
