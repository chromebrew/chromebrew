require 'buildsystems/ruby'

class Ruby_xmlrpc < RUBY
  description 'XMLRPC is a lightweight protocol that enables remote procedure calls over HTTP.'
  homepage 'https://github.com/ruby/xmlrpc'
  version "0.3.4-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby' => :logical
  depends_on 'ruby_webrick' # R

  conflicts_ok
  no_compile_needed
end
