require 'buildsystems/meson'

class Libgnt < Meson
  description 'GNT is an ncurses toolkit for creating text-mode graphical user interfaces in a fast and easy way.'
  homepage 'https://keep.imfreedom.org/libgnt/libgnt'
  version '2.14.3'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/pidgin/libgnt/#{version}/libgnt-#{version}.tar.xz"
  source_sha256 '57f5457f72999d0bb1a139a37f2746ec1b5a02c094f2710a339d8bcea4236123'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0f1d7253d300ebee18ab940a708db7acfaf1cb911ff9c8abab0a83059a7a69b1',
     armv7l: '0f1d7253d300ebee18ab940a708db7acfaf1cb911ff9c8abab0a83059a7a69b1',
       i686: '3047f5c8cd450467cdd281878f36f4f7d99da015cc0db21f9eb3dc13db075d1a',
     x86_64: 'bee673b82722ce2637f6b0ad854b40e7a9130da1f7c6e6a022291e86f418cde6'
  })

  depends_on 'glib'
  depends_on 'libxml2'
  depends_on 'ncurses'

  def self.patch
    # Use panel_window instead of directly accessing the struct member
    Downloader.download 'https://keep.imfreedom.org/libgnt/libgnt/raw-rev/2da723f790d6', '6cb459fb35b9142390b6c3ea6af5ea031cb69b3f4248cba7e50ff32d51107ef0'
    system 'git apply 2da723f790d6'

    # A proper fix to this should probably be upstreamed, given that most distros patch this ncurses check somehow.
    system "sed -i 's|/usr|#{CREW_PREFIX}|' meson.build"
  end

  # Python support was removed upstream anyways, so we can drop this when we upgrade to the next release.
  meson_options '-Dpython2=false -Ddoc=false'
end
